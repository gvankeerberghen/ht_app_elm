module Technologies.Edit exposing (..)

import CommonView
import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Msgs exposing (Msg)
import Models exposing (Technology)
import Routing exposing (technologiesPath)
import Html.Events exposing (onClick)


view : Technology -> Html Msg
view model =
    div [ class "mdl-layout mdl-js-layout mdl-layout--fixed-header"]
        [ CommonView.nav <| CommonView.title (div [][ listBtn])
        , content model
        ]


nav : Technology -> Html Msg
nav model =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ listBtn ]

content : Technology -> Html Msg
content model =
    div [class "mdl-layout__content"] [
        div [class "mdl-grid"] [
            div [class "mdl-cell mdl-cell--3-col"] [
                form model
            ]
        ]
    ]


form : Technology -> Html Msg
form technology =
    div [ class "mdl-card mdl-shadow--2dp" ]
        [   
            div [ class "mdl-card__title" ] 
            [
                span [class "mdl-card__title-text"] [text technology.name]
            ]
            , div [class "mdl-card__supporting-text"] [
                formVote technology
            ]
        ]


formVote : Technology -> Html Msg
formVote technology =
    div
        [ class "clearfix py1"
        ]
        [ div [ class "col col-5" ] [ text "Votes" ]
        , div [ class "col col-7" ]
            [ span [ class "h2 bold" ] [ text (toString technology.votes) ]
            , btnLevelDecrease technology
            , btnLevelIncrease technology
            ]
        ]


btnLevelDecrease : Technology -> Html Msg
btnLevelDecrease technology =
    let 
        message = 
            Msgs.ChangeVotes technology -1
    in
        a [ class "btn ml1 h1", onClick message]
            [ i [ class "fa fa-minus-circle" ] [] ]


btnLevelIncrease : Technology -> Html Msg
btnLevelIncrease technology =
    let 
        message = 
            Msgs.ChangeVotes technology 1
    in
        a [ class "btn ml1 h1", onClick message ]
            [ i [ class "fa fa-plus-circle" ] [] ]


listBtn : Html Msg
listBtn =
    a
        [ class "btn regular"
        , href technologiesPath
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]