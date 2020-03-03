module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (value, type_, class)

selectClasses =
  "block appearance-none w-full border shadow py-2 px-3 pr-8 rounded"

main =
    div [ class "flex justify-center py-10" ]
        [ div [ class "w-full max-w-xs" ]
            [ h1 [ class "text-center text-2xl mb-6" ] [ text "Conversor de Moedas" ]
            , form [ class "bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4" ]
                [ div [ class "mb-4" ]
                    [ label [ class "block text-gray-700 text-sm font-bold mb-2" ]
                        [ text "Moeda de origem" ]
                    , div [ class "relative" ]
                        [ select
                            [ class selectClasses ]
                            [ option [ value "BRL"] [ text "Real" ] 
                            , option [ value "USD"] [ text "Dólar americano" ]
                            , option [ value "EUR"] [ text "Euro" ] 
                            ]
                        ]
                    ]
                , div [ class "mb-4" ]
                    [ label [ class "block text-gray-700 text-sm font-bold mb-2" ]
                        [ text "Moeda de destino"
                        ]
                    , div [ class "relative" ]
                        [ select
                            [ class "block appearance-none w-full border shadow py-2 px-3 pr-8 rounded" ]
                            [ option [ value "USD" ] [ text "Dólar americano" ]
                            , option [ value "BRL" ] [ text "Real" ] 
                            , option [ value "EUR" ] [ text "Euro" ] 
                            ]
                        ]
                    ]
                , div [ class "mb-6" ]
                    [ label [ class "block text-gray-700 text-sm font-bold mb-2" ]
                        [ text "Quantidade"
                        ]
                    , input [ type_ "number", class "shadow appearence-none border rounded w-full py-2 px-3 text-gray" ] []
                    ]
                , div [ class "flex w-full" ]
                    [ button [ class "bg-blue-500 w-full hover:bg-blue-700 text-white font-bold py-2 px-4" ] [ text "Converter" ] ]
                ]
            ]
        ]
