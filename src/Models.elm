module Models exposing (..)

import RemoteData exposing (WebData)

type alias Model =
    {technologies: WebData (List Technology)
    , route: Route
    }

initialModel : Route -> Model
initialModel route =
    { technologies = RemoteData.Loading
    , route = route
    }

type alias TechId = 
    Int

type alias Technology = 
    { id: TechId
    , name: String
    , votes: Int
    }


type Route
    = TechnologiesRoute
    | TechnologyRoute TechId
    | NotFoundRoute