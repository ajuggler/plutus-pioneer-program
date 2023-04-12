{-# LANGUAGE DataKinds           #-}
{-# LANGUAGE ImportQualifiedPost #-}
{-# LANGUAGE NoImplicitPrelude   #-}
{-# LANGUAGE TemplateHaskell     #-}

module Homework1 where

import qualified Plutus.V2.Ledger.Api as PlutusV2
<<<<<<< HEAD
import qualified PlutusTx             (compile)
import           PlutusTx.Prelude     (Bool (..), BuiltinData, (&&))
import           Utilities            (wrap)
=======
import           PlutusTx             (compile)
import           PlutusTx.Prelude     (Bool (..), BuiltinData)
import           Utilities            (wrapValidator)
>>>>>>> 9e90225050cb647f3ce47907956d86fd7e38154e

---------------------------------------------------------------------------------------------------
----------------------------------- ON-CHAIN / VALIDATOR ------------------------------------------

{-# INLINABLE mkValidator #-}
-- This should validate if and only if the two Booleans in the redeemer are True!
mkValidator :: () -> (Bool, Bool) -> PlutusV2.ScriptContext -> Bool
mkValidator _ (a,b) _ = a && b

wrappedVal :: BuiltinData -> BuiltinData -> BuiltinData -> ()
wrappedVal = wrapValidator mkValidator

validator :: PlutusV2.Validator
validator = PlutusV2.mkValidatorScript $$(PlutusTx.compile [|| wrappedVal ||])
