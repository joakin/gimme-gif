module Components.Error exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Components.Utils exposing (when)

view : String -> Html a
view err =
  when err <| div [ class "Error" ] [ text err ]
