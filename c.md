# C

Glorious language.

## Forward Type Declaration in Parameter Lists

This is a GNU C language extension:

```c
const char *inet_ntop(socklen_t size;
                      int af, const void *restrict src,
                      char dst[restrict size], socklen_t size);
```

Encountered it on some man pages. It's just a forward declaration but scoped
inside of parameter list.

C99 introduced VLA. So you could now do `void foo(int n, int arr[n])`. This
works fine. But older POSIX calls tend to have size as the last parameter.
Because of that this GNU C extension is used to forward declare the parameter
beforehand signaling the compiler. This way they can still use VLA function
signature.

Documentation from GNU C: [6.2.1 Arrays of Variable Length](https://gcc.gnu.org/onlinedocs/gcc/Variable-Length.html)
