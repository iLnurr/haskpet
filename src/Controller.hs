module Controller where

import Data.Aeson
import Database
import Yesod

import Foundation
import Models

getUserR :: Handler Value
getUserR = do
  users <- runDB getUsers
  returnJson users

postUserR :: Handler Value
postUserR = do
  user <- requireCheckJsonBody :: Handler User
  userId <- runDB $ insertUser user
  returnJson user