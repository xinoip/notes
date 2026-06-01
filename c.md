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

## Pointer Wrapping Struct

If a function needs to modify a pointer, you need to pass a pointer to that
pointer. This results in a double pointer. Working with double pointers is
cumbersome. Especially doing pointer arithmetic on them. For example:

```c
int **ptr;
*ptr++; // Increments double pointer itself, then dereference old address.
(*ptr)++; // Increments actual underlying pointer.
```

Idea is to wrap the pointer in a struct. This way you can pass a pointer to
that struct. Then you can use the pointer as if it was a normal pointer:

```c
typedef struct {
  int *ptr;
} Cursor;

void foo(MyPtr *cursor) {
  printf("%d\n", *(cursor->ptr));
  cursor->ptr++;
}
```

These are often named 'Cursors' in C codebases.
