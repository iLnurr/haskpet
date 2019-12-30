import Application () -- for YesodDispatch instance
import Foundation
import User
import Yesod
import Database.Persist.Sqlite
import Control.Monad.Trans.Resource (runResourceT)
import Control.Monad.Logger (runStderrLoggingT)

main :: IO ()
main =
  runStderrLoggingT $
  withSqlitePool "test.db3" openConnectionCount $ \pool ->
    liftIO $ do
      runResourceT $ flip runSqlPool pool $ runMigration migrateAll
      warp 3000 $ App pool