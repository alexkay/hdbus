-- HDBus -- Haskell bindings for D-Bus.
-- Copyright (C) 2006 Evan Martin <martine@danga.com>

#define DBUS_API_SUBJECT_TO_CHANGE
#include "dbus/dbus.h"

{-# LANGUAGE CPP, DeriveDataTypeable #-}

module DBus (
  module DBus.Shared,

  -- * Error Handling
  -- | Some D-Bus functions can only fail on out-of-memory conditions.
  -- I don't think there is much we can do in those cases.
  --
  -- Other D-Bus functions can fail with other sorts of errors, which are
  -- raised as dynamic exceptions.  Errors can be caught with
  -- 'Control.Exception.catch', like this:
  --
  -- > do conn <- DBus.busGet DBus.System
  -- >    doSomethingWith conn
  -- > `catch` (\(DBus.Error name msg) -> putStrLn ("D-Bus error! " ++ msg))
  --
  Error(..),
) where

import DBus.Shared
import Data.Typeable
import Control.Exception

-- |'Error's carry a name (like \"org.freedesktop.dbus.Foo\") and a
-- message (like \"connection failed\").
data Error = Error String String deriving (Typeable)
instance Show Error where
  show (Error name message) = "D-Bus Error (" ++ name ++ "): " ++ message
instance Exception Error

-- vim: set ts=2 sw=2 tw=72 et ft=haskell :
