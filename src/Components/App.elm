port module Components.App exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Task
import Json.Decode as Json
import String
import Dict exposing (Dict)


-- Ports


{-| Save a favorite in storage by query and url
-}
port saveFav : ( String, String ) -> Cmd msg



-- Model


type alias Flags =
    { favs : Json.Value
    }


type alias Favs =
    Dict String (List String)


jsonToFavs : Json.Value -> Result String Favs
jsonToFavs json =
    Json.decodeValue (Json.dict <| Json.list <| Json.string)
        json


type alias Model =
    { query : String
    , fetching : Bool
    , gif : String
    , error : String
    , favs : Favs
    }


init : Flags -> ( Model, Cmd Msg )
init { favs } =
    let
        favs_ =
            case (jsonToFavs favs) of
                Ok fs ->
                    fs

                Err err ->
                    Dict.empty
    in
        Model "" False "" "" favs_ ! []



-- Update


type Msg
    = Submit
    | UpdateQuery String
    | GifReceive String
    | GifFail Http.Error


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "MSG: " msg of
        UpdateQuery newQuery ->
            { model | query = newQuery } ! []

        Submit ->
            { model | fetching = True } ! [ getRandomGif model.query ]

        GifReceive url ->
            { model | fetching = False, gif = url } ! []

        GifFail err ->
            { model | fetching = False, error = (toString err) } ! []



-- View


view : Model -> Html Msg
view model =
    div [ class "App" ]
        [ h1 [] [ text "Gimme a gif 👊" ]
        , searchForm model.query
        , error model.error
        , if model.fetching then
            p [] [ text "Loading..." ]
          else
            gif model.gif
        , favs model.favs
        , p [ class "giphy" ]
            [ text "Powered by "
            , a [ href "http://giphy.com" ] [ text "giphy.com" ]
            ]
        ]


gif : String -> Html a
gif url =
    when url <|
        div [ class "Gif" ]
            [ input [ type_ "text", readonly True, value url ] []
            , img [ src url ] []
            ]


error : String -> Html a
error err =
    when err <| div [ class "Error" ] [ text """
    No result found!
    """ ]


searchForm : String -> Html Msg
searchForm _ =
    Html.form [ class "SearchForm", onSubmit Submit ]
        [ input
            [ placeholder "search for gifs related to..."
            , onInput UpdateQuery
            ]
            []
        ]


favs : Favs -> Html Msg
favs fs =
    let
        favsByQuery : ( String, List String ) -> Html Msg
        favsByQuery ( query, favs_ ) =
            div []
                [ h3 [] [ text query ]
                , div [] <| List.map (\f -> img [ height 80, src f ] []) favs_
                ]
    in
        div [] <|
            List.map favsByQuery
                (Dict.toList fs)


when : String -> Html a -> Html a
when str node =
    if String.isEmpty str then
        text ""
    else
        node



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- Effects


getRandomGif : String -> Cmd Msg
getRandomGif topic =
    let
        url =
            "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
    in
        Task.perform GifFail GifReceive (Http.get decodeGifUrl url)


decodeGifUrl : Json.Decoder String
decodeGifUrl =
    Json.oneOf
        [ Json.at [ "data", "image_url" ] Json.string
        , Json.fail "No result found"
        ]
