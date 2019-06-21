module UniverseTest where

{-| In which we test that the universe is still functioning correctly.
   If these fail then we can't trust any of the other tests.
-}

import Lib.Prelude
import Test.Tasty (TestTree)
import Test.Tasty.HUnit (testCase, assertEqual)

test_universe :: TestTree
test_universe = testCase "Maths. And the universe in general" $ sequence_
  [ assertEqual "+" 2 (1 + 1)
  , assertEqual "-" 0 (1 - 1)
  , assertEqual "*" 1 (1 * 1)
  , assertEqual "/" 1 (1 / 1)
  ]
