module MFA
  ( generateToken
  ) where

import           Codec.Utils (Octet, fromTwosComp)
import           Data.Bits   ((.&.))
import           Data.HMAC   (hmac_sha1)
import           MFA.Util
import           Text.Printf

-- Takes a base32-encoded secret and returns an MFA token
generateToken :: String -> IO String
generateToken secret = fmap (generateToken' secret) epochSeconds

-- Takes a base32-encoded secret and the current epoch timestamp and returns an MFA token
generateToken' :: String -> Int -> String
generateToken' secretBase32 epochSeconds = token
  where
    secret = decodeBase32 secretBase32
    timeInterval = 30
    timeCounter = epochSecondsToTimeCounter timeInterval epochSeconds
    hash = hmac_sha1 secret timeCounter
    token = hashToToken hash

epochSecondsToTimeCounter :: Int -> Int -> [Octet]
epochSecondsToTimeCounter timeInterval epochSeconds = octets
  where
    intervals = epochSeconds `div` timeInterval
    zeroPaddedHex = printf "%016x" intervals
    octets = hexToOctets zeroPaddedHex

hashToToken :: [Octet] -> String
hashToToken hash = paddedToken
  where
    offset = fromTwosComp [last hash .&. 15]
    truncatedHash =
      [ (hash !! offset) .&. 127
      , hash !! (offset + 1)
      , hash !! (offset + 2)
      , hash !! (offset + 3)
      ]
    integer = fromTwosComp truncatedHash
    token = integer `mod` 1000000 :: Int
    paddedToken = printf "%06d" token
