module Components.Gif exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Components.Utils exposing (when)


view : String -> Html a
view url =
    when url
        <| div [ class "Gif" ]
            [ input [ type' "text", readonly True, value url ] []
            , img [ src url ] []
            ]
