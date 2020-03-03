module Main exposing (main)

import Browser
import Dict
import Html exposing (..)
import Html.Attributes exposing (value, type_, class, selected)
import Html.Events exposing (onInput, onSubmit)

selectClasses =
  "block appearance-none w-full border shadow py-3 px-3 pr-8 rounded"

brl =
    Dict.fromList
        [ ( "EUR", 0.21 )
        , ( "USD", 0.23 )
        ]

usd =
    Dict.fromList
        [ ( "EUR", 0.92 )
        , ( "BRL", 4.42 )
        ]

eur =
    Dict.fromList
        [ ( "USD", 1.09 )
        , ( "BRL", 4.81 )
        ]

currencies =
    Dict.fromList
        [ ( "BRL", brl )
        , ( "EUR", eur )
        , ( "USD", usd )
        ]

type alias Model =
    { from : String
    , to : String
    , amount : Float
    , result : Float
    }

type Msg
    = ChangeOriginCurrency String
    | ChangeDestinyCurrency String
    | ChangeAmount String
    | SubmitForm

initialModel : Model
initialModel =
    { from = "BRL"
    , to = "EUR"
    , amount = 0
    , result = 0
    }

update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeOriginCurrency currencyCode ->
            { model | from = currencyCode }
        ChangeDestinyCurrency currencyCode ->
            { model | to = currencyCode }
        ChangeAmount amount ->
            case String.toFloat amount of
              Just value ->
                  { model | amount = value }
              Nothing ->
                  model
        SubmitForm ->
            let
                availableCurrencies =
                    Maybe.withDefault Dict.empty (Dict.get model.from currencies)

                destinyCurrencyValue =
                    Maybe.withDefault 1 (Dict.get model.to availableCurrencies)

                result =
                    destinyCurrencyValue * model.amount
            in
                { model | result = result }

view : Model -> Html Msg
view model =
    div [ class "flex justify-center py-10" ]
        [ div [ class "w-full max-w-xs" ]
            [ h1 [ class "text-center text-2xl mb-6" ] [ text "Conversor de Moedas" ]
            , form [ onSubmit SubmitForm, class "bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4" ]
                [ div [ class "mb-4" ]
                    [ label [ class "block text-gray-700 text-sm font-bold mb-2" ]
                        [ text "Moeda de origem" ]
                    , div [ class "relative" ]
                        [ select
                            [ class selectClasses, value model.from, onInput ChangeOriginCurrency ]
                            [ option [ value "BRL", selected (model.from == "BRL") ] [ text "Real" ] 
                            , option [ value "USD",selected (model.from == "USD") ] [ text "Dólar americano" ]
                            , option [ value "EUR", selected (model.from == "EUR") ] [ text "Euro" ] 
                            ]
                        ]
                    ]
                , div [ class "mb-4" ]
                    [ label [ class "block text-gray-700 text-sm font-bold mb-2" ]
                        [ text "Moeda de destino"
                        ]
                    , div [ class "relative" ]
                        [ select
                            [ class selectClasses, value model.to, onInput ChangeDestinyCurrency ]
                            [ option [ value "USD", selected (model.to == "USD") ] [ text "Dólar americano" ]
                            , option [ value "BRL", selected (model.to == "BRL") ] [ text "Real" ] 
                            , option [ value "EUR", selected (model.to == "EUR") ] [ text "Euro" ] 
                            ]
                        ]
                    ]
                , div [ class "mb-6" ]
                    [ label [ class "block text-gray-700 text-sm font-bold mb-2" ]
                        [ text "Quantidade"
                        ]
                    , input [ type_ "number", onInput ChangeAmount, value (String.fromFloat model.amount), class "shadow appearence-none border rounded w-full py-2 px-3 text-gray" ] []
                    ]
                , div [ class "flex w-full" ]
                    [ button [ class "bg-blue-500 w-full hover:bg-blue-700 text-white font-bold py-2 px-4" ] [ text "Converter" ] ]
                , div [ class "flex w-full text-center mt-5 text-gray-700 text-sm" ]
                    [ text ("Convertendo " ++ String.fromFloat model.amount ++ " " ++ model.from ++ " para " ++ model.to ++ " totalizando " ++ String.fromFloat model.result ++ " " ++ model.to) ]
                ]
            ]
        ]

main : Program () Model Msg
main =
  Browser.sandbox
      { init = initialModel
      , view = view
      , update = update
      }

