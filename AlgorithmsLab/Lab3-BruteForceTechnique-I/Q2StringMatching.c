#include <stdio.h>
#include <string.h>

void main() {
    char s1[50], s2[50];
    int i, flag = 1;
    printf("Enter string 1 ");
    scanf("%s",s1);
    printf("Enter string 2 ");
    scanf("%s",s2);
    for (i=0; i < strlen(s1); i++)
        if (s1[i] != s2[i]) 
            flag = 0;
    if (flag)
        printf("Strings are equal");
    else
        printf("Strings are not equal");
}