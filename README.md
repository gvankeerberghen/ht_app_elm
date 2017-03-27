# HT simple web app in Elm
A try at Elm to have a simple web app that shows a list of interesting technologies
and allows to cast votes on them.

Currently highly based on this SPA [elm-tutorial](https://www.elm-tutorial.org)

## Dependencies
- Elm
- Node (tested with v6.1)
- yarn

## Deploy
``yarn install``
``yarn start``
Should start fake api at [localhost:4000](http://localhost:4000) and webapp at [localhost:3000](http://localhost:3000)

## To do
- add tech type in model and list
- sort list on number of votes
- add user, with login by Google account
- change votes to allow one per user per tech
- use [elm-mdl](https://github.com/debois/elm-mdl) to make it look descent
- replace the mock json-api with a real backend
