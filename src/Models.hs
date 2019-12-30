module Models where

import Data.Aeson
import Database.Persist
import Database.Persist.TH

share
  [mkPersist sqlSettings, mkMigrate "migrateAll"]
  [persistLowerCase|
User
    name String
    age Int
    deriving Show
|]

instance ToJSON User where
  toJSON (User name age) = object ["name" .= name, "age" .= age]

instance FromJSON User where
  parseJSON = withObject "User" $ \v -> User <$> v .: "name" <*> v .: "age"

instance ToJSON (Entity User) where
  toJSON = entityIdToJSON