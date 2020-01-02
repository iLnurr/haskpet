module Database where

import Database.Persist
import Database.Persist.Sqlite
import Database.Persist.TH
import Control.Monad.Reader (ReaderT, MonadIO)

import Models

getUsers :: MonadIO m => ReaderT SqlBackend m [Entity User]
getUsers = selectList ([] :: [Filter User]) []

insertUser :: MonadIO m => User -> ReaderT SqlBackend m (Key User)
insertUser = insert


