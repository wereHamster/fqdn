#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>
#include <unistd.h>

int c_fullyQualifiedDomainName(char *buffer, size_t bufferLength)
{
    /* Get the hostname. */
    if (gethostname(buffer, bufferLength) == -1)
        return -1;

    /* Resolve the hostname into an addrinfo structure. */
    struct addrinfo *ai = NULL;
    if (getaddrinfo(buffer, NULL, NULL, &ai) != 0)
        return -1;

    /* Look up the FQDN of the address, store the result in the buffer. */
    int ret = getnameinfo(
        ai->ai_addr, ai->ai_addrlen,
        buffer, bufferLength,
        NULL, 0, 0
    );

    /* Free the resources allocated by getaddrinfo. */
    freeaddrinfo(ai);

    return !! ret;
}
