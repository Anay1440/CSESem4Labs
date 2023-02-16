#include <stdio.h>
#include <stdlib.h>

int find(int arr[], int n, int x) {
    int i;
    for (i = 0; i < n; i++)
        if (arr[i] == x)
            return 1;
    return 0;
}

void getNCR(int arr[], int data[], int start, int end, int ind, int r, int halfSum, int * completed) {
    int i;
    if (*completed == 1)
        return;

    if (ind == r) {
        int sum = 0;
        for (i = 0; i < r; i++)
            sum += data[i];
        if (sum == halfSum) {
            printf("Set 1: ");
            for (i = 0; i < r; i++)
                printf("%d ", data[i]);
            printf("\nSet 2: ");
            for (i = 0; i <= end; i++) {
                if (!find(data, r, arr[i])) 
                    printf("%d ", arr[i]);
            }
            printf("\n");
            *completed = 1;
        }
    }
    else {
        for (i = start; i <= end && end - i + 1 >= r - ind; i++) {
            data[ind] = arr[i];
            getNCR(arr, data, i+1, end, ind+1, r, halfSum, completed);
        }
    }
}

void main() {
    int n,i, sum = 0;
    printf("Enter length of array ");
    scanf("%d",&n);
    int r = n / 2;
    int * arr = (int *) malloc(n * sizeof(int));
    int * data = (int *) malloc(r * sizeof(int));
    for (i = 0; i < n; i++) {
        printf("Enter arr[%d] ",i);
        scanf("%d",&arr[i]);
        sum += arr[i];
    }
    if (sum % 2 != 0)
        printf("Not possible.\n");
    else {
        int completed = 0;
        for (i = 1; i <= r; i++) {
            getNCR(arr, data, 0, n - 1, 0, i, sum/2, &completed);
        }
        if (!completed)
            printf("Not possible.\n");
    }
}