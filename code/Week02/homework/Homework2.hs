{-# LANGUAGE DataKinds           #-}
{-# LANGUAGE DeriveAnyClass      #-}
{-# LANGUAGE DeriveGeneric       #-}
{-# LANGUAGE ImportQualifiedPost #-}
{-# LANGUAGE NoImplicitPrelude   #-}
{-# LANGUAGE TemplateHaskell     #-}

module Homework2 where

import qualified Plutus.V2.Ledger.Api as PlutusV2
<<<<<<< HEAD
import qualified PlutusTx             (compile, unstableMakeIsData)
import           PlutusTx.Prelude     (Bool, not, BuiltinData, ($))
--import           Prelude              (undefined)
import           Utilities            (wrap)
=======
import           PlutusTx             (unstableMakeIsData)
import           PlutusTx.Prelude     (Bool, BuiltinData)
import           Prelude              (undefined)
--import           Utilities            (wrapValidator)
>>>>>>> 9e90225050cb647f3ce47907956d86fd7e38154e

---------------------------------------------------------------------------------------------------
----------------------------------- ON-CHAIN / VALIDATOR ------------------------------------------

data MyRedeemer = MyRedeemer
    { flag1 :: Bool
    , flag2 :: Bool
    }

PlutusTx.unstableMakeIsData ''MyRedeemer

{-# INLINABLE mkValidator #-}
-- Create a validator that unlocks the funds if MyRedemeer's flags are different
mkValidator :: () -> MyRedeemer -> PlutusV2.ScriptContext -> Bool
mkValidator () red _ = if flag1 red then not $ flag2 red else flag2 red

wrappedVal :: BuiltinData -> BuiltinData -> BuiltinData -> ()
wrappedVal = wrap mkValidator

validator :: PlutusV2.Validator
validator = PlutusV2.mkValidatorScript $$(PlutusTx.compile [|| wrappedVal ||])
