module Main
  ( main
  ) where

import           MFA

secret :: String
secret = "2HZ53IOC2XPQZDT24UHSTTUNYDHQ6A5FUX7SFIZ2LEHG6IYSC33L7EOJ5YMOZUWA"

main :: IO ()
main = do
  token <- generateToken secret
  putStrLn token
