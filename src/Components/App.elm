module Components.App exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Http
import Task
import Json.Decode as Json
import Components.Utils exposing (when)

import Components.SearchForm as SearchForm

-- Model

type alias Model =
  { search : SearchForm.Model
  , fetching : Bool
  , gif : String
  , error : String
  }

init : (Model, Cmd Msg)
init =
  let
    (searchModel, searchCmds) = SearchForm.init
  in
    (Model searchModel False "" "", Cmd.map SearchForm searchCmds)


-- Update

type Msg
  = SearchForm SearchForm.Msg
  | GifReceive String
  | GifFail Http.Error


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case Debug.log "MSG: " msg of
    SearchForm SearchForm.Search ->
      model ! [ getRandomGif model.search ]

    SearchForm msg ->
      let
        (searchModel, searchEffects) = SearchForm.update msg model.search
      in
        { model | search = searchModel } ! [ Cmd.map SearchForm searchEffects ]

    GifReceive url ->
      { model | gif = url } ! []

    GifFail err ->
      { model | error = (toString err) } ! []


-- View

view : Model -> Html Msg
view model =
  div
    [ class "App" ]
    [ h1 [] [ text "Gimme a gif 👊" ]
    , App.map SearchForm (SearchForm.view model.search)
    , error model.error
    , gif model.gif
    , p [ class "giphy" ]
      [ text "Powered by "
      , a [ href "http://giphy.com" ] [ text "giphy.com" ]
      ]
    ]


gif url =
  when url <|
    div [ class "Gif" ]
      [ input [ type' "text", readonly True, value url ] []
      , img [ src url ] []
      ]
    

error err =
  when err <| div [ class "Error" ] [ text err ]


-- Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


-- Effects

getRandomGif : String -> Cmd Msg
getRandomGif topic =
  let
    url = "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
  in
    Task.perform GifFail GifReceive (Http.get decodeGifUrl url)


decodeGifUrl : Json.Decoder String
decodeGifUrl =
  Json.at ["data", "image_url"] Json.string

