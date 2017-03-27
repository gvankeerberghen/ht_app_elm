module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (TechId, Route(..))
import UrlParser exposing (..)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map TechnologiesRoute top
        , map TechnologyRoute (s "technologies" </> int)
        , map TechnologiesRoute (s "technologies")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute

technologiesPath : String
technologiesPath =
    "#technologies"


technologyPath : TechId -> String
technologyPath id =
    "#technologies/" ++ (toString id)