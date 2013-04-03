This cabal package exposes module `Network.FQDN`, which provides one function,
`fullyQualifiedDomainName :: IO (Maybe String)`.

The FQDN is retrieved using [getaddrinfo/getnameinfo][getaddrinfo] POSIX functions.
It should be reasonably portable, but has only been tested on Linux.

WARNING: Do not statically link your application when using glibc (most Linux
distributions). See this bug: http://sourceware.org/bugzilla/show_bug.cgi?id=10652.

[getaddrinfo]: http://en.wikipedia.org/wiki/Getaddrinfo
