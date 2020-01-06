module Controller where

import Data.Aeson as A
import Database
import Yesod

import Foundation
import Models

import Network.JsonRpc.Server
import Data.List (intercalate)
import Data.Maybe (fromMaybe)
import Control.Monad.Trans (liftIO)
import Control.Monad.Except (throwError)
import Data.Conduit
import qualified Data.Conduit.Text as CT
import qualified Data.Conduit.List as CL
import qualified Data.ByteString.Lazy as LB

getUserR :: Handler Value
getUserR = do
  users <- liftIO getUsers
  returnJson users

postUserR :: Handler Value
postUserR = do
  user <- requireCheckJsonBody :: Handler User
  userId <- liftIO $ insertUser user
  returnJson user

postRequestR :: Handler TypedContent
postRequestR = do
  texts <- rawRequestBody $$ CL.consume
  let body = LB.fromChunks texts
  bs <- liftIO (call methods body)
  return $ TypedContent typeOctet $ toContent $ fromMaybe LB.empty bs

methods :: [Method IO]
methods = [add, list]

add = toMethod "add" f (Required "user" :+: ())
  where
    f :: User -> RpcResult IO Value
    f u = do
      key <- liftIO $ insertUser u
      returnJson key

list = toMethod "list" f ()
  where f :: RpcResult IO Value
        f = do
          users <- liftIO getUsers
          returnJson users
