module MFA.Util
  ( stringToOctets
  , decodeBase32
  , hexToOctets
  , epochSeconds
  ) where

import           Codec.Utils               (Octet)
import qualified Data.Base32String.Default as B32 (b32String, toBytes)
import           Data.ByteString           (pack, unpack)
import           Data.Char                 (ord)
import qualified Data.HexString            as Hex (hexString, toBytes)
import           Data.Time.Clock.POSIX     (getPOSIXTime)

stringToOctets :: String -> [Octet]
stringToOctets = map (fromIntegral . ord)

decodeBase32 :: String -> [Octet]
decodeBase32 = unpack . B32.toBytes . B32.b32String . pack . stringToOctets

hexToOctets :: String -> [Octet]
hexToOctets =
  tail .
  unpack . Hex.toBytes . Hex.hexString . pack . stringToOctets . ("10" ++)

epochSeconds :: IO Int
epochSeconds = fmap round getPOSIXTime
