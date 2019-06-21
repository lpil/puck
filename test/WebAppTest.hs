module WebAppTest where

import qualified Lib
import Lib.Prelude hiding (get)
import Test.Tasty (TestTree)
import Test.Tasty.Wai (assertBodyContains, assertStatus, get, testWai)

test_homeRoute :: TestTree
test_homeRoute = testWai Lib.app "GET /" $ do
  res <- get "/"
  assertStatus 200 res
  assertBodyContains "Hello, sailor!" res


test_readyCheckRoute :: TestTree
test_readyCheckRoute = testWai Lib.app "GET /-/ready" $ do
  res <- get "/-/ready"
  assertStatus 200 res


test_healthCheckRoute :: TestTree
test_healthCheckRoute = testWai Lib.app "GET /-/health" $ do
  res <- get "/-/health"
  assertStatus 200 res


test_unknownRoute :: TestTree
test_unknownRoute = testWai Lib.app "GET /not-a-thing" $ do
  res <- get "/not-a-thing"
  assertStatus 404 res
  assertBodyContains "There&#39;s nothing here..." res
