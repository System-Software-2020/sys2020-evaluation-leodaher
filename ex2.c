#include <unistd.h>
#include <sys/syscall.h>

ssize_t write (int fd, const void *s, size_t n){
    syscall(4, fd, s, n);
    return 0;
}
