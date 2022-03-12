#include <stdio.h>

// 0x100
int* x;

// 0x300
void foo() {
    int i = 1;
    int j = 2;
    bar(3, 4);
    bar(i, j);
    return;
}

// 0x200
void bar(int i, int j) {
    i += x[j];
    x[j] = i;
    return;
}

// 0x0
int main() {
    foo();
    for (int i=0; i<10; i++) {
        printf("%d\n", x[i]);
    }
    return 0;
}