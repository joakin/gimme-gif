module Components.SearchForm exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model = String

init : (Model, Cmd Msg)
init = "" ! []


type Msg
  = Search
  | UpdateQuery String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    UpdateQuery newQuery ->
      newQuery ! []

    Search -> model ! []


view : Model -> Html Msg
view model =
  Html.form [ class "SearchForm", onSubmit Search ]
    [ input
      [ placeholder "search for gifs related to..."
      , onInput UpdateQuery ] []
    ]
