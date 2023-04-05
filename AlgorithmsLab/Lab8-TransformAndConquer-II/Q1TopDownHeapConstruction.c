#include <stdio.h>
#include <stdlib.h>

void heapifyUP(int arr[], int n, int *opCount) {
    //n - 1 is index of element inserted in heap (last element of array)
    int i,v,heapify,k,j;
    k = (n-1-1)/2; //index of parent node
    heapify = 0;
    if (0 == n - 1) {
        // if last element is root
        heapify = 1;
    }
    v = arr[k]; //value of parent node
    i = n - 1;
    while (heapify == 0 && k >= 0) {
        if ( i-1 > 0 && (i-1-1)/2 == k) {
            // if root of element before last element has same parent as last element
            if (arr[n-1] < arr[n-2]) {
                // if last element is smaller than element before last element
                i = n - 2;
            }
        }
        if (v >= arr[i]) {
            // if parent is greater than both children
            heapify = 1;
        }
        else {
            arr[k] = arr[i];
            arr[i] = v;
            i = k;
            k = (k-1)/2;
            v = arr[k];
        }
        *opCount = *opCount + 1;
    }
}

void main() {
    int i,n,j, opCount = 0;
    printf("Enter n ");
    scanf("%d",&n);
    int * arr = (int *) calloc(n, sizeof(int));
    for(i=0;i<n;i++) {
        printf("Enter a[%d] ",i);
        scanf("%d",&arr[i]);
    }
    for(i=0;i<n;i++) 
        heapifyUP(arr,i+1,&opCount);
    printf("Heap: ");
    for(j=0;j<n;j++)
        printf("%d ",arr[j]);
    printf("\nOpCount: %d\n", opCount);
}