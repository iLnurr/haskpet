module Controller where

import Data.Aeson
import Yesod
import Database.Persist
import Database.Persist.Sqlite
import Database.Persist.TH

import Foundation
import User

getUserR :: Handler Value
getUserR = do
  users <- runDB $ selectList ([] :: [Filter User]) []
  returnJson users

postUserR :: Handler Value
postUserR = do
  user <- requireCheckJsonBody :: Handler User
  userId <- runDB $ insert user
  returnJson user