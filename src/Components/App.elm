module Components.App exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String
import Http
import Task
import Json.Decode as Json


-- Model

type alias Model =
  { tags : String
  , fetching : Bool
  , gif : String
  , error : String
  }

init : (Model, Cmd Msg)
init = Model "" False "" "" ! []


-- Update

type Msg
  = UpdateTags String
  | NewGif
  | GifReceive String
  | GifFail Http.Error


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    UpdateTags tags ->
      { model | tags = tags } ! []

    NewGif ->
      model ! [ getRandomGif model.tags ]

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
    , Html.form [ class "Input", onSubmit NewGif ]
      [ input
        [ placeholder "search for gifs related to..."
        , onInput UpdateTags ] []
      ]
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
    url = "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
  in
    Task.perform GifFail GifReceive (Http.get decodeGifUrl url)


decodeGifUrl : Json.Decoder String
decodeGifUrl =
  Json.at ["data", "image_url"] Json.string

