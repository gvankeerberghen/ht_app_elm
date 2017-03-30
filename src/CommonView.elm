module CommonView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Msgs exposing (Msg)

nav : String -> Html Msg
nav title =
    header [ class "mdl-layout__header"] 
    [  
        div [ class "mdl-layout__header-row" ] 
        [
                span [ class "mdl-layout-title"] [ text title] 
        ] 
    ]