module Update exposing (..)


import Msgs exposing (Msg)
import Models exposing (Model, Technology)
import Routing exposing (parseLocation)
import Commands exposing (saveTechnologyCmd)
import RemoteData


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchTechnologies response ->
            ( { model | technologies = response }, Cmd.none )

        Msgs.OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )
        
        Msgs.ChangeVotes tech diff ->
            let
                updatedTech =
                    { tech | votes = tech.votes + diff }
            in
                ( model, saveTechnologyCmd updatedTech )

        Msgs.OnTechnologySave (Ok tech) ->
            ( updateTech model tech, Cmd.none )

        Msgs.OnTechnologySave (Err error) ->
            ( model, Cmd.none )


updateTech : Model -> Technology -> Model
updateTech model updatedTech =
    let
        pick currentTech =
            if updatedTech.id == currentTech.id then
                updatedTech
            else
                currentTech

        updateTechList techs =
            List.map pick techs

        updatedTechnologies =
            RemoteData.map updateTechList model.technologies
    in
        { model | technologies = updatedTechnologies }