#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

struct string {
    int n;
    char* c;
};

struct string str1 = {
    .n = 30,
    .c = "Welcome! Please enter a name:\n"
};

struct string str2 = {
    .n = 11,
    .c = "Good luck,\n"
};

struct string str3 = {
    .n = 43,
    .c = "The secret phrase is \"squeamish ossifrage\""
};

void print(struct string* str) {
    // write to 1 (standard output)
    write(1, str->c, str->n);
}

void proof() {
    print(&str3);
}


int main() {
    char buf1[64 * sizeof(int)];
    print(&str1);
    int name_size = read(0, buf1, sizeof(buf1));
    print(&str2);
}