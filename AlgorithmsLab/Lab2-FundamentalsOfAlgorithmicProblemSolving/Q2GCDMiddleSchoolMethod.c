#include <stdio.h>
#include <math.h>

void getPrimeFactors(int n, int pf[50]) {
    int ind = 0, i;
    while (n % 2 == 0) {
        pf[ind++] = 2;
        n = n / 2;
    }

    for (i=3; i <= sqrt(n); i = i + 2) {
        while (n % i == 0) {
            pf[ind++] = i;
            n = n / i;
        }
    }

    if (n > 2)
        pf[ind++] = n;
}

void main() {
    int n1, n2, x, i, gcd = 1, ind1 = 0, ind2 = 0;
    printf("Enter first number ");
    scanf("%d",&n1);
    printf("Enter second number ");
    scanf("%d",&n2);
    int pf1[50], pf2[50];
    getPrimeFactors(n1, pf1);
    getPrimeFactors(n2, pf2);
    while (pf1[ind1] != 0 && pf2[ind2] != 0) {
        if (pf1[ind1] == pf2[ind2]) {
            gcd = gcd * pf1[ind1];
            ind1++;
            ind2++;
        }
        else if (pf1[ind1] < pf2[ind2])
            ind1++;
        else
            ind2++;
    }
    printf("GCD of %d and %d is %d", n1, n2, gcd);
}