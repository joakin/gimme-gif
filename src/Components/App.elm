module Components.App exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Http
import Task
import Json.Decode as Json
import Components.SearchForm as SearchForm exposing (Event(Search))
import Components.Gif as Gif
import Components.Error as Error


-- Model


type alias Model =
    { search : SearchForm.Model
    , fetching : Bool
    , gif : String
    , error : String
    }


init : ( Model, Cmd Msg )
init =
    Model (SearchForm.init) False "" "" ! []



-- Update


type Msg
    = SearchForm SearchForm.Msg
    | GifReceive String
    | GifFail Http.Error


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "MSG: " msg of
        SearchForm sfmsg ->
            let
                ( sfmodel, event ) =
                    SearchForm.update sfmsg model.search
            in
                ( { model | search = sfmodel }
                , case event of
                    Just Search ->
                        getRandomGif model.search

                    Nothing ->
                        Cmd.none
                )

        GifReceive url ->
            { model | gif = url } ! []

        GifFail err ->
            { model | error = (toString err) } ! []



-- View


view : Model -> Html Msg
view model =
    div [ class "App" ]
        [ h1 [] [ text "Gimme a gif 👊" ]
        , App.map SearchForm (SearchForm.view model.search)
        , Error.view model.error
        , Gif.view model.gif
        , p [ class "giphy" ]
            [ text "Powered by "
            , a [ href "http://giphy.com" ] [ text "giphy.com" ]
            ]
        ]



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
    Json.at [ "data", "image_url" ] Json.string
