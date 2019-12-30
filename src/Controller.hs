module Controller where

import Data.Aeson
import Database.Persist
import Database.Persist.Sqlite
import Database.Persist.TH
import Yesod

import Foundation
import Models

getUserR :: Handler Value
getUserR = do
  users <- runDB $ selectList ([] :: [Filter User]) []
  returnJson users

postUserR :: Handler Value
postUserR = do
  user <- requireCheckJsonBody :: Handler User
  userId <- runDB $ insert user
  userDB <- runDB $ get userId
  returnJson userDB