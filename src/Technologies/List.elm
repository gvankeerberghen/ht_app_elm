module Technologies.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Msgs exposing (Msg)
import Models exposing (Technology)
import RemoteData exposing (WebData)
import Routing exposing (technologyPath)
import Html.Events exposing (onClick)


view : WebData (List Technology) -> Html Msg
view response =
    div [ class "mdl-layout mdl-js-layout mdl-layout--fixed-header"]
        [ 
            nav
            , content response

        ]

content : WebData (List Technology) -> Html Msg
content response =
    div [class "mdl-layout__content"] [
        maybeList response
    ]

nav : Html Msg
nav =
    header [ class "mdl-layout__header"] 
    [  
        div [ class "mdl-layout__header-row" ] 
        [
                span [ class "mdl-layout-title"] [ text "Technologies"] 
        ] 
    ]


maybeList : WebData (List Technology) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success technologies ->
            list technologies

        RemoteData.Failure error ->
            text (toString error)


list : List Technology -> Html Msg
list technologies =
    div [ class "mdl-grid" ]
        [
            div [class "mdl-cell mdl-cell--12-col"]
                [ table [ class "mdl-data-table mdl-js-data-table mdl-data-table--selectable mdl-shadow--2dp"]
                    [ thead []
                        [ tr []
                            [ th [] [ text "Id" ]
                            , th [ class "mdl-data-table__cell--non-numeric" ] [ text "Name" ]
                            , th [] [ text "Votes" ]
                            ]
                        ]
                    , tbody [] (List.map techRow technologies)
                    ]
                ]
        ]


techRow : Technology -> Html Msg
techRow tech =
    tr []
        [ td [] [ text (toString tech.id) ]
        , td [ class "mdl-data-table__cell--non-numeric" ] [ text tech.name ]
        , td [] [ 
            div []
            [
                btnLevelDecrease tech
                , span [] [text (toString tech.votes) ]
                , btnLevelIncrease tech
            ]
          ]
        ]

formVote : Technology -> Html Msg
formVote technology =
    div []
        [ 
            btnLevelDecrease technology
            , btnLevelIncrease technology
        ]

btnLevelClass: String
btnLevelClass =
    "mdl-button mdl-js-button mdl-button--accent mdl-button--icon"

btnLevelDecrease : Technology -> Html Msg
btnLevelDecrease technology =
    let 
        message = 
            Msgs.ChangeVotes technology -1
    in
        button [ class btnLevelClass , onClick message]
            [ i [ class "material-icons" ] [ text "remove" ] ]


btnLevelIncrease : Technology -> Html Msg
btnLevelIncrease technology =
    let 
        message = 
            Msgs.ChangeVotes technology 1
    in
        button [ class btnLevelClass , onClick message ]
            [ i [ class "material-icons" ] [ text "add"] ]



editBtn : Technology -> Html.Html Msg
editBtn tech =
    let
        path =
            technologyPath tech.id
    in
        a
            [ class "btn regular"
            , href path
            ]
            [ i [ class "fa fa-pencil mr1" ] []]