#include <stdio.h>
#include <stdlib.h>

void heapBottomUp(int arr[], int left, int right, int * opCount) {
    int i, v, heapify, k, j, n = right - left;
    for(i = (n/2)-1+left; i >= left; i--) {
        k = i;
        v = arr[k];
        heapify = 0;
        while (heapify == 0 && (2*(k - left) + 1 + left) < right) {
            j = 2*(k - left) + 1 + left;
            if (j < right - 1)
                if (arr[j] > arr[j+1])
                    j = j + 1;
            if (v <= arr[j])
                heapify = 1;
            else {
                arr[k] = arr[j];
                k = j;
            }
            *opCount = *opCount + 1;
        }
        arr[k] = v;
    }
}

void main() {
    int i,n,j,opCount = 0;
    printf("Enter n ");
    scanf("%d",&n);
    int * arr = (int *) calloc(n, sizeof(int));
    for(i=0;i<n;i++) {
        printf("Enter a[%d] ",i);
        scanf("%d",&arr[i]);
    }
    for(i=0;i<n;i++) 
        heapBottomUp(arr,i,n,&opCount);
    printf("Sorted array: ");
    for(j=0;j<n;j++)
        printf("%d ",arr[j]);
    printf("\nOpCount: %d",opCount);
}