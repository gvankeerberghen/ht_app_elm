module CommonView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Msgs exposing (Msg)

nav : Html Msg -> Html Msg
nav content =
    header [ class "mdl-layout__header"] 
    [  
        div [ class "mdl-layout__header-row" ] 
        [
            content
        ] 
    ]

title: Html Msg -> Html Msg
title content= 
    span [ class "mdl-layout-title"] [ content ] 