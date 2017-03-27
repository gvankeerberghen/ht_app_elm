module Msgs exposing (..)

import Http
import Models exposing (Technology)
import RemoteData exposing (WebData)
import Navigation exposing (Location)


type Msg
    = OnFetchTechnologies (WebData (List Technology))
    | OnLocationChange Location
    | ChangeVotes Technology Int
    | OnTechnologySave (Result Http.Error Technology)