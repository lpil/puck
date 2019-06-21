module Lib
  ( app
  , router
  )
where

import Protolude
import Lucid
import qualified Data.ByteString.Lazy as LazyBS
import qualified Network.Wai as Wai
import qualified Network.HTTP.Types.Status as Status
import Network.HTTP.Types.Method (StdMethod(GET), parseMethod)
import Network.Wai.Middleware.Autohead (autohead)
import Network.Wai.Middleware.MethodOverride (methodOverride)
import Network.Wai.Middleware.MethodOverridePost (methodOverridePost)
import Network.Wai.Middleware.Timeout (timeout)



app :: Wai.Application
app = timeout 30 >> methodOverridePost >> methodOverride >> autohead $ router


router :: Wai.Application
router request respond =
  let
    method = request & Wai.requestMethod & parseMethod & fromRight GET
    path   = Wai.pathInfo request
  in respond $ case (method, path) of
    (GET, []             ) -> homePage
    (GET, ["-", "health"]) -> healthCheck
    (GET, ["-", "ready"] ) -> readyCheck
    (_  , _              ) -> notFoundPage


healthCheck :: Wai.Response
healthCheck = Wai.responseLBS Status.ok200 [] ""


readyCheck :: Wai.Response
readyCheck = Wai.responseLBS Status.ok200 [] ""


homePage :: Wai.Response
homePage = Wai.responseLBS Status.ok200 [] $ html $ do
  h1_ "Hello, sailor!"
  "Welcome home"


notFoundPage :: Wai.Response
notFoundPage = Wai.responseLBS Status.notFound404 [] $ html $ do
  h1_ "There's nothing here..."
  a_ [href_ "/"] "Back to home"


html :: Html a -> LazyBS.ByteString
html markup = renderBS $ doctypehtml_ $ do
  head_ $ do
    meta_ [charset_ "utf-8"]
    meta_ [name_ "viewport", content_ "width=device-width"]
    link_ [href_ "/public/main.css", rel_ "stylesheet"]
    link_ [href_ "/main.css", rel_ "stylesheet"]
    title_ "Puck"
  body_ markup
