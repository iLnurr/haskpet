module Controller where

import Data.Aeson
import Database
import Yesod
import qualified Data.Conduit.Text as CT
import qualified Data.Conduit.List as CL

import Foundation
import Models

getUserR :: Handler Value
getUserR = do
  users <- liftIO getUsers
  returnJson users

postUserR :: Handler Value
postUserR = do
  user <- requireCheckJsonBody :: Handler User
  userId <- liftIO $ insertUser user
  returnJson user