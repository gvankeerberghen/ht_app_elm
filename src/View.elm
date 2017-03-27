module View exposing (..)


import Html exposing (Html, div, text)
import Msgs exposing (Msg)
import Models exposing (Model, TechId)
import Technologies.List
import Technologies.Edit
import RemoteData

view : Model -> Html Msg
view model =
    div []
        [ page model ]

page: Model -> Html Msg
page model = 
    case model.route of
        Models.TechnologiesRoute -> 
            Technologies.List.view model.technologies

        Models.TechnologyRoute id ->
            technologyEditPage model id

        Models.NotFoundRoute ->
            notFoundView


technologyEditPage : Model -> TechId -> Html Msg
technologyEditPage model techId =
    case model.technologies of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading ..."

        RemoteData.Success technologies ->
            let
                maybeTech =
                    technologies
                        |> List.filter (\tech -> tech.id == techId)
                        |> List.head
            in
                case maybeTech of
                    Just tech ->
                        Technologies.Edit.view tech

                    Nothing ->
                        notFoundView

        RemoteData.Failure err ->
            text (toString err)


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]