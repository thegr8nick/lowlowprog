#include <stdio.h>
#include <stdbool.h>
#include <locale.h>

int main() {
    setlocale(LC_ALL, "");
    int numb;
    int i = 2;
    bool is_prime = true;
    printf("Введите число: ");
    scanf_s("%d", &numb);
    if (numb <= 1) {
        is_prime = false;
        goto prime_check;
    }
loop_check:
    if (i * i > numb) {
        goto prime_check;
    }
    if (numb % i == 0) {
        is_prime = false;
        goto prime_check;
    }
    ++i;
    goto loop_check;
prime_check:
    if (is_prime) {
        printf("Простое");
    }
    else {
        printf("Не простое");
    }
    return 0;
}