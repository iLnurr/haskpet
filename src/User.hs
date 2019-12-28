module User where

import GHC.Generics
import           Data.Text (Text)
import           Data.Aeson
import           Yesod
import Foundation

data User = User
    { name :: Text
    , age  :: Int 
    } deriving Generic
    
instance ToJSON User  where
  toEncoding = genericToEncoding defaultOptions
instance FromJSON User

getUserR :: Handler Value
getUserR = returnJson $ User "Michael" 28

postUserR :: Handler Value
postUserR = returnJson $ User "Michael" 34
