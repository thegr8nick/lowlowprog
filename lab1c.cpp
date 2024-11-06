#include <stdio.h>
#include <stdbool.h>
#include <locale.h>

bool is_prime(int numb) {
    if (numb <= 1) {
        return false;
    }
    if (numb <= 3) {
        return true;
    }
    if ((numb % 2 == 0) or (numb % 3 == 0)) {
        return false;
    }
    for (int i = 5; i * i <= numb; i += 6) {
        if ((numb % i == 0) or (numb % (i + 2) == 0)) {
            return false;
        }
    }
    return true;
}

int main() {
    setlocale(LC_ALL, "");
    int n;
    printf("Введите число: ");
    scanf("%d", &n);
    if (is_prime(n)) {
        printf("%d является простым числом", n);
    } else {
        printf("%d не является простым числом", n);
    }
    return 0;
}