#include <stdio.h>
#include <stdlib.h>

void merge(int arr[], int left, int mid, int right) {

    if (left >= right || arr == NULL)
        return;

    int * finalArr = (int *) malloc((right - left + 1) * sizeof(int));

    int i = left;
    int j = mid + 1;
    int ind = 0;

    while (i <= mid && j <= right) {
        if (arr[i] < arr[j]) {
            finalArr[ind++] = arr[i];
            i++;
        } else {
            finalArr[ind++] = arr[j];
            j++;
        }
    }

    while (i <= mid) {
        finalArr[ind++] = arr[i];
        i++;
    }

    while (j <= right) {
        finalArr[ind++] = arr[j];
        j++;
    }

    ind = 0;
    for (i = left; i <= right; i++)
        arr[i] = finalArr[ind++];

    free(finalArr);
}

void mergeSort(int arr[], int left, int right) {

    if (arr == NULL || left >= right)
        return;

    int mid = (left + right) / 2;

    if (left < mid)
        mergeSort(arr, left, mid);

    if (mid + 1 < right)
        mergeSort(arr, mid + 1, right);

    merge(arr, left, mid, right);
}


void main() {
    int n, i;
    printf("Enter the number of elements: ");
    scanf("%d", &n);
    int * arr = (int *) malloc(n * sizeof(int));
    for(i = 0; i < n; i++) {
        printf("Enter arr[%d]: ", i);
        scanf("%d", &arr[i]);
    }
    printf("Sorted array: ");
    mergeSort(arr, 0, n);
    for (int i = 0; i < n; i++)
        printf("%d ", arr[i]);
}