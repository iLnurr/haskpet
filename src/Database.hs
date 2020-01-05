module Database where

import Database.Persist
import Database.Persist.Sqlite
import Database.Persist.TH
import Control.Monad.Reader (ReaderT, MonadIO)

import Models

import Control.Monad.Trans.Resource
import Control.Monad.Trans.Control
import Control.Monad.Logger

withDbRun :: SqlPersistT (NoLoggingT (ResourceT IO)) b -> IO b
withDbRun = runSqlite "test.db3"

getUsers :: IO [Entity User]
getUsers = withDbRun $ selectList ([] :: [Filter User]) []

insertUser :: User -> IO (Key User)
insertUser u = withDbRun $ insert u


