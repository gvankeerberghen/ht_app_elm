module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Json.Encode as Encode
import Msgs exposing (Msg)
import Models exposing (TechId, Technology)
import RemoteData


fetchTechnologies : Cmd Msg
fetchTechnologies =
    Http.get fetchTechnologiesUrl technologiesDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchTechnologies


fetchTechnologiesUrl : String
fetchTechnologiesUrl =
    "http://localhost:4000/technologies"


technologiesDecoder : Decode.Decoder (List Technology)
technologiesDecoder =
    Decode.list techDecoder


techDecoder : Decode.Decoder Technology
techDecoder =
    decode Technology
        |> required "id" Decode.int
        |> required "name" Decode.string
        |> required "votes" Decode.int

saveTechnologyUrl : TechId -> String
saveTechnologyUrl techId =
    "http://localhost:4000/technologies/" ++ (toString techId)


saveTechnologyRequest : Technology -> Http.Request Technology
saveTechnologyRequest tech =
    Http.request
        { body = techEncoder tech |> Http.jsonBody
        , expect = Http.expectJson techDecoder
        , headers = []
        , method = "PATCH"
        , timeout = Nothing
        , url = saveTechnologyUrl tech.id
        , withCredentials = False
        }


saveTechnologyCmd : Technology -> Cmd Msg
saveTechnologyCmd tech =
    saveTechnologyRequest tech
        |> Http.send Msgs.OnTechnologySave


techEncoder : Technology -> Encode.Value
techEncoder tech =
    let
        attributes =
            [ ( "id", Encode.int tech.id )
            , ( "name", Encode.string tech.name )
            , ( "votes", Encode.int tech.votes )
            ]
    in
        Encode.object attributes