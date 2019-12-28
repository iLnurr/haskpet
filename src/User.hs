module User where

import           Data.Text (Text)
import           Data.Aeson
import           Yesod
import Foundation

data User = User
    { name :: Text
    , age  :: Int 
    }
    
instance ToJSON User where
    toJSON User {..} = object
        [ "name" .= name
        , "age"  .= age
        ]

getUserR :: Handler Value
getUserR = returnJson $ User "Michael" 28

postUserR :: Handler Value
postUserR = returnJson $ User "Michael" 34
