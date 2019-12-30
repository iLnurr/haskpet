module Foundation where

import Yesod
import Database.Persist.Sqlite

newtype App = App ConnectionPool

mkYesodData "App" $(parseRoutesFile "routes")

instance Yesod App

instance YesodPersist App where
    type YesodPersistBackend App = SqlBackend

    runDB action = do
        App pool <- getYesod
        runSqlPool action pool
        
openConnectionCount :: Int
openConnectionCount = 10