module Network.FQDN (fullyQualifiedDomainName) where

import Foreign
import Foreign.C
import Foreign.C.Types


foreign import ccall unsafe "c_fullyQualifiedDomainName"
    c_fullyQualifiedDomainName :: CString -> CSize -> IO CInt


-- | Return the fully qualified domain name (if available). Not all hosts have
--   a FQDN defined. If the FQDN is not available, you can fall back to
--   `Network.BSD.getHostName`.

fullyQualifiedDomainName :: IO (Maybe String)
fullyQualifiedDomainName = do
    allocaArray0 bufferLength $ \cstr -> do
        res <- c_fullyQualifiedDomainName cstr (fromIntegral bufferLength)
        if res == 0
            then peekCString cstr >>= return . Just
            else return Nothing

  where

    -- The max buffer size for the FQDN.
    bufferLength = 200
