#include <stdio.h>
#include <stdbool.h>
#include <locale.h>

int main() {
    setlocale(LC_ALL, "");
    int numb;
    bool is_prime = true;
    printf("Введите число: ");
    scanf_s("%d", &numb);
    if (numb <= 1) {
        is_prime = false;
    }
    for (int i = 2; i * i <= numb; ++i) {
        if (numb % i == 0) {
            is_prime = false;
        }
    }
    if (is_prime) {
        printf("Простое");
    } 
    else {
        printf("Не простое");
    }
    return 0;
}