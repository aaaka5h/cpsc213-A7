#include <stdio.h>

long x[8] = {1, 2, 3, -1, -2, 0, 184, 340057058};
long y[8] = {0, 0, 0, 0, 0, 0, 0, 0};

int f(long arg1) {
    int j = 0;
    long k = arg1;
    while (k != 0) {
        if ((k & 0x8000000) != 0) {
            j++;
        } 
        k = (k << 1);
    }
    return j;
}

void main() {
    int i = 8;
    while (i > 0) {
        i--;
        y[i] = f(x[i]);
    }

    for (int i=0; i<8; i++) {
        printf("%ld\n", x[i]);
    }

    for (int i=0; i<8; i++) {
        printf("%ld\n", y[i]);
    }
}