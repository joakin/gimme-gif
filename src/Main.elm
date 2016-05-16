import Html.App as HtmlApp
import Components.App as App

main =
  HtmlApp.program
    { init = App.init
    , view = App.view
    , update = App.update
    , subscriptions = App.subscriptions
    }
