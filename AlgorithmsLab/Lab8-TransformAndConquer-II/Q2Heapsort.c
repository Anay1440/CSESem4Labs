#include <stdio.h>
#include <stdlib.h>

void heapify(int arr[], int n, int i, int * opCount) {
    int k, v, heapify,j;
    k = i;
    v = arr[k];
    heapify = 0;
    while (heapify == 0 && 2*k + 1 < n) {
        j = 2*k + 1;
        if (j < n - 1)
            if (arr[j] < arr[j+1])
                j = j + 1;
        if (v >= arr[j])
            heapify = 1;
        else {
            arr[k] = arr[j];
            k = j;
        }
        *opCount = *opCount + 1;
    }
    arr[k] = v;
}

void heapBottomUp(int arr[], int n, int * opCount) {
    int i, v, k, j;
    for(i = (n/2)-1; i >= 0; i--) 
        heapify(arr,n,i,opCount);
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
    heapBottomUp(arr,n,&opCount);
    for(i=0;i<n-1;i++) {
        j = arr[0];
        arr[0] = arr[n-i-1];
        arr[n-i-1] = j;
        heapify(arr,n - i - 1,0,&opCount);
    }
    printf("Sorted array: ");
    for(j=0;j<n;j++)
        printf("%d ",arr[j]);
    printf("\nOpCount: %d\n",opCount);
}