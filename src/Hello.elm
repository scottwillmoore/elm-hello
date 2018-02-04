module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Keyed
import Array exposing (Array)
import Time exposing (Time, second, millisecond)
import Task
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
        , Greeting "Khmer" "សួស្តី\x200Bពិភពលោក!"
        , Greeting "Kyrgyz" "Салам дүйнө!"
        , Greeting "Lao" "ສະ\x200Bບາຍ\x200Bດີ\x200Bຊາວ\x200Bໂລກ!"
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
    { greeting : Greeting
    , lastTime : Time
    , lastReset : Time
    }


init : ( Model, Cmd Msg )
init =
    ( (Model defaultGreeting 0 0), Task.perform Reset Time.now )



-- UPDATE


type Msg
    = Roll
    | Show Int
    | Tick Time
    | Reset Time


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Reset newTime ->
            ( { model
                | lastTime = newTime
                , lastReset = newTime
              }
            , Cmd.none
            )

        Tick newTime ->
            if newTime - model.lastTime > 3 * second then
                ( { model | lastTime = newTime }
                , Random.generate Show randomGreeting
                )
            else
                ( model, Cmd.none )

        Roll ->
            ( model, Random.generate Show randomGreeting )

        Show index ->
            let
                greeting =
                    Array.get index greetings
                        |> Maybe.withDefault defaultGreeting
            in
                ( { model | greeting = greeting }
                , Task.perform Reset Time.now
                )



-- SUBSCRIPTIONS


tickRate =
    20 * millisecond


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every tickRate Tick



-- VIEW


view : Model -> Html Msg
view model =
    Html.Keyed.node "div"
        [ class "container", onClick Roll ]
        [ ( model.greeting.language
          , div [ class "hero" ]
                [ h1 [] [ text model.greeting.phrase ]
                , p [] [ text model.greeting.language ]
                ]
          )
        , ( toString model.lastReset
          , div [ class "progress" ] []
          )
        ]
