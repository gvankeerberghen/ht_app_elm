module Technologies.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Msgs exposing (Msg)
import Models exposing (Technology)
import RemoteData exposing (WebData)
import Routing exposing (technologyPath)


view : WebData (List Technology) -> Html Msg
view response =
    div []
        [ nav
        , maybeList response
        ]


nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ] [ text "Technologies" ] ]


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
    div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "Id" ]
                    , th [] [ text "Name" ]
                    , th [] [ text "Votes" ]
                    ]
                ]
            , tbody [] (List.map techRow technologies)
            ]
        ]


techRow : Technology -> Html Msg
techRow tech =
    tr []
        [ td [] [ text (toString tech.id) ]
        , td [] [ text tech.name ]
        , td [] [ text (toString tech.votes) ]
        , td []
            [editBtn tech]
        ]

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
            [ i [ class "fa fa-pencil mr1" ] [], text "Edit" ]