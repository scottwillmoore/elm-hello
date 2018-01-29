module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Keyed
import Array exposing (Array)
import Random


type alias Greeting =
    { language : String
    , phrase : String
    }


greetings : Array Greeting
greetings =
    Array.fromList
        [ Greeting "Afrikaans" "Hello Wêreld!"
        , Greeting "Albanian" "Përshendetje Botë!"
        , Greeting "Amharic" "ሰላም ልዑል!"
        , Greeting "Arabic" "مرحبا بالعالم!"
        , Greeting "Armenian" "Բարեւ աշխարհ!"
        , Greeting "Basque" "Kaixo Mundua!"
        , Greeting "Belarussian" "Прывітанне Сусвет!"
        , Greeting "Bengali" "ওহে বিশ্ব!"
        , Greeting "Bulgarian" "Здравей свят!"
        , Greeting "Catalan" "Hola món!"
        , Greeting "Chichewa" "Moni Dziko Lapansi!"
        , Greeting "Chinese" "你好世界！"
        , Greeting "Croatian" "Pozdrav svijete!"
        , Greeting "Czech" "Ahoj světe!"
        , Greeting "Danish" "Hej Verden!"
        , Greeting "Dutch" "Hallo Wereld!"
        , Greeting "English" "Hello World!"
        , Greeting "Estonian" "Tere maailm!"
        , Greeting "Finnish" "Hei maailma!"
        , Greeting "French" "Bonjour monde!"
        , Greeting "Frisian" "Hallo wrâld!"
        , Greeting "Georgian" "გამარჯობა მსოფლიო!"
        , Greeting "German" "Hallo Welt!"
        , Greeting "Greek" "Γειά σου Κόσμε!"
        , Greeting "Hausa" "Sannu Duniya!"
        , Greeting "Hebrew" "שלום עולם!"
        , Greeting "Hindi" "नमस्ते दुनिया!"
        , Greeting "Hungarian" "Helló Világ!"
        , Greeting "Icelandic" "Halló heimur!"
        , Greeting "Igbo" "Ndewo Ụwa!"
        , Greeting "Indonesian" "Halo Dunia!"
        , Greeting "Italian" "Ciao mondo!"
        , Greeting "Japanese" "こんにちは世界！"
        , Greeting "Kazakh" "Сәлем Әлем!"
        , Greeting "Khmer" "សួស្តី​ពិភពលោក!"
        , Greeting "Kyrgyz" "Салам дүйнө!"
        , Greeting "Lao" "ສະ​ບາຍ​ດີ​ຊາວ​ໂລກ!"
        , Greeting "Latvian" "Sveika pasaule!"
        , Greeting "Lithuanian" "Labas pasauli!"
        , Greeting "Luxemburgish" "Moien Welt!"
        , Greeting "Macedonian" "Здраво свету!"
        , Greeting "Malay" "Hai dunia!"
        , Greeting "Malayalam" "ഹലോ വേൾഡ്!"
        , Greeting "Mongolian" "Сайн уу дэлхий!"
        , Greeting "Myanmar" "မင်္ဂလာပါကမ္ဘာလောက!"
        , Greeting "Nepali" "नमस्कार संसार!"
        , Greeting "Norwegian" "Hei Verden!"
        , Greeting "Pashto" "سلام نړی!"
        , Greeting "Persian" "سلام دنیا!"
        , Greeting "Polish" "Witaj świecie!"
        , Greeting "Portuguese" "Olá Mundo!"
        , Greeting "Punjabi" "ਸਤਿ ਸ੍ਰੀ ਅਕਾਲ ਦੁਨਿਆ!"
        , Greeting "Romanian" "Salut Lume!"
        , Greeting "Russian" "Привет мир!"
        , Greeting "Scots Gaelic" "Hàlo a Shaoghail!"
        , Greeting "Serbian" "Здраво Свете!"
        , Greeting "Sesotho" "Lefatše Lumela!"
        , Greeting "Sinhala" "හෙලෝ වර්ල්ඩ්!"
        , Greeting "Slovenian" "Pozdravljen svet!"
        , Greeting "Spanish" "¡Hola Mundo!"
        , Greeting "Sundanese" "Halo Dunya!"
        , Greeting "Swahili" "Salamu Dunia!"
        , Greeting "Swedish" "Hej världen!"
        , Greeting "Tajik" "Салом Ҷаҳон!"
        , Greeting "Thai" "สวัสดีชาวโลก!"
        , Greeting "Turkish" "Selam Dünya!"
        , Greeting "Ukrainian" "Привіт Світ!"
        , Greeting "Uzbek" "Salom Dunyo!"
        , Greeting "Vietnamese" "Chào thế giới!"
        , Greeting "Welsh" "Helo Byd!"
        , Greeting "Xhosa" "Molo Lizwe!"
        , Greeting "Yiddish" "העלא וועלט!"
        , Greeting "Yoruba" "Mo ki O Ile Aiye!"
        , Greeting "Zulu" "Sawubona Mhlaba!"
        ]


defaultGreeting =
    Greeting "English" "Hello World!"


randomGreeting =
    Random.int 0 ((Array.length greetings) - 1)



-- PROGRAM


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    Greeting


init : ( Model, Cmd Msg )
init =
    ( defaultGreeting, Cmd.none )



-- UPDATE


type Msg
    = Roll
    | Show Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model, Random.generate Show randomGreeting )

        Show index ->
            let
                greeting =
                    Array.get index greetings
                        |> Maybe.withDefault defaultGreeting
            in
                ( greeting, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    Html.Keyed.node "div"
        [ class "container", onClick Roll ]
        [ ( model.language
          , div [ class "hero" ]
                [ h1 [] [ text model.phrase ]
                , p [] [ text model.language ]
                ]
          )
        ]
