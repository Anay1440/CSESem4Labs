#include <stdio.h>

void main() {
    int n1, n2, x, i, gcd;
    printf("Enter first number ");
    scanf("%d",&n1);
    printf("Enter second number ");
    scanf("%d",&n2);
    x = n1 < n2 ? n1 : n2;
    for (i = 1; i <= x; i++) 
        if (n1 % i == 0 && n2 % i == 0)
            gcd = i;
    printf("GCD of %d and %d is %d", n1, n2, gcd);
}