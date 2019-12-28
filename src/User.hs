module User where

import Yesod.Core
import Foundation

data User = User

getUserR :: Handler Html
getUserR = defaultLayout [whamlet|Users|]

postUserR :: Handler Html
postUserR = defaultLayout [whamlet|User|]
