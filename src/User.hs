module User where

import Data.Text (Text)
import Data.Aeson
import Yesod
import Foundation

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
User
    name String
    age Int
    deriving Show
|]

instance ToJSON User  where
  toJSON (User name age) = object ["name" .= name, "age" .= age]
instance FromJSON User where
  parseJSON = withObject "User" $ \v -> User
    <$> v .: "name"
    <*> v .: "age"

getUserR :: Handler Value
getUserR = returnJson $ User "Michael" 28

postUserR :: Handler Value
postUserR = do
  user <- requireCheckJsonBody :: Handler User
  returnJson user
