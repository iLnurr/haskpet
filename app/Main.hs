import Application () -- for YesodDispatch instance
import Control.Monad.Logger (runStderrLoggingT)
import Control.Monad.Trans.Resource (runResourceT)
import Database.Persist.Sqlite
import Foundation
import User
import Yesod

main :: IO ()
main =
  runStderrLoggingT $
  withSqlitePool "test.db3" openConnectionCount $ \pool ->
    liftIO $ do
      runResourceT $ flip runSqlPool pool $ runMigration migrateAll
      warp 3000 $ App pool