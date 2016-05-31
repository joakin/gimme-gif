module Components.SearchForm exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    String


init : Model
init =
    ""


type Msg
    = Submit
    | UpdateQuery String


type Event
    = Search


update : Msg -> Model -> ( Model, Maybe Event )
update msg model =
    case msg of
        UpdateQuery newQuery ->
            ( newQuery, Nothing )

        Submit ->
            ( model, Just Search )


view : Model -> Html Msg
view model =
    Html.form [ class "SearchForm", onSubmit Submit ]
        [ input
            [ placeholder "search for gifs related to..."
            , onInput UpdateQuery
            ]
            []
        ]
