#include <stdio.h>
#include <stdlib.h>

#define max(a,b) (a > b) ? a : b

int knapsack(int weights[], int values[], int n, int maxWeight) {
    int i, j, ** mat = (int **) malloc((n+1) * sizeof(int *));

    for(i = 0; i <= n; i++) 
        mat[i] = (int *) calloc(maxWeight+1,sizeof(int));

    for(i = 0; i <= n; i++) {
        for(j = 0; j <= maxWeight; j++) {
            if (i == 0 || j == 0)
                mat[i][j] = 0;
            else if (weights[i-1] <= j)
                mat[i][j] = max(values[i-1] + mat[i-1][j-weights[i-1]], mat[i-1][j]);
            else
                mat[i][j] = mat[i-1][j];
        }
    }

    return mat[n][maxWeight];
}

void main() {

    int i, n, maxWeight;
    printf("Enter number of items ");
    scanf("%d",&n);

    int * weights = (int *) malloc(n * sizeof(int));
    int * values = (int *) malloc(n * sizeof(int));

    for(i = 0; i < n; i++) {
        printf("Enter weight of item %d ",i+1);
        scanf("%d",&weights[i]);
        printf("Enter value of item %d ",i+1);
        scanf("%d",&values[i]);
    }

    printf("Enter maximum weight ");
    scanf("%d",&maxWeight);

    printf("Maximum value: %d\n",knapsack(weights,values,n,maxWeight));

}