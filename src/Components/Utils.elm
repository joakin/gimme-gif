module Components.Utils exposing (..)

import Html exposing (Html, text)
import String


when : String -> Html a -> Html a
when str node =
  if String.isEmpty str then
    text ""
  else
    node

