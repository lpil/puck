module Main where

import Lib.Prelude
import qualified Lib
import qualified Network.Wai.Handler.Warp as Warp
import Network.Wai.Middleware.RequestLogger (logStdoutDev)

-- Font is ANSI FIGlet Delta Corps Priest 1
splash :: Int -> Text
splash port =
  [ ""
    , "   ▄███████▄ ███    █▄   ▄████████    ▄█   ▄█▄ "
    , "  ███    ███ ███    ███ ███    ███   ███ ▄███▀ "
    , "  ███    ███ ███    ███ ███    █▀    ███▐██▀   "
    , "  ███    ███ ███    ███ ███         ▄█████▀    "
    , "▀█████████▀  ███    ███ ███        ▀▀█████▄    "
    , "  ███        ███    ███ ███    █▄    ███▐██▄   "
    , "  ███        ███    ███ ███    ███   ███ ▀███▄ "
    , " ▄████▀      ████████▀  ████████▀    ███   ▀█▀ "
    , "                                     ▀         "
    , "     ✨ Listening on localhost:" <> show port <> " ✨"
    , ""
    ]
    & intersperse "\n"
    & mconcat

main :: IO ()
main =
  let
    port = 3000
    run =
      Warp.defaultSettings
        & Warp.setPort port
        & Warp.setHost "127.0.0.1"
        & Warp.runSettings
    app = Lib.app & logStdoutDev
  in putStrLn (splash port) >> run app
