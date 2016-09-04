module Main exposing (..)

import Html.App as HtmlApp
import Components.App as App exposing (Flags)


main : Program Flags
main =
    HtmlApp.programWithFlags
        { init = App.init
        , view = App.view
        , update = App.update
        , subscriptions = App.subscriptions
        }
