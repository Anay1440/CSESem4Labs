#include <stdio.h>

void main() {
    int n1, n2, x, i, gcd, opCount = 0;
    printf("Enter both numbers ");
    scanf("%d %d",&n1, &n2);
    x = n1 < n2 ? n1 : n2;
    for (i = x; i >= 1; i--) {
        opCount++;
        if (n1 % i == 0 && n2 % i == 0) {
            gcd = i;
            break;
        }
    }
    printf("GCD of %d and %d is %d\nOpcount is: %d\n", n1, n2, gcd, opCount);
}
