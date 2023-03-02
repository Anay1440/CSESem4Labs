#include <stdio.h>
#include <stdlib.h>

void swap(int *a, int *b){
    int temp = *a;
    *a = *b;
    *b = temp;
}

void permute(int arr[], int n, double * mat[], int l, int r, double *cost, int res[], int * opCount) {
    int i;
    if (l == r) {
        double tempCost = 0;
        for (i = 0; i < n ; i++) 
            tempCost += mat[i][arr[i]];
        *opCount = *opCount + n + 1;
        if (*cost > tempCost) {
            *cost = tempCost;
            for(i=0;i<n;i++) 
                res[i] = arr[i];
            *opCount = *opCount + n;
        }
    }
    else {
        for (i = l; i <= r ; i++) {
            swap(&arr[l],&arr[i]);
            permute(arr,n,mat,l+1,r,cost,res,opCount);
            swap(&arr[l],&arr[i]);
        }
    }
}

void main() {
    int n,jobs,i,j,opCount = 0;
    printf("Enter the number of employees and jobs ");
    scanf("%d",&n);
    double ** mat = (double **) calloc (n,sizeof(double *));
    int * arrForPerm = (int *) calloc(n,sizeof(int));
    int * res = (int *) calloc(n,sizeof(int));
    for (i = 0; i < n ; i++) {
        mat[i] = (double *) calloc (n,sizeof(double));
        arrForPerm[i] = i;
    }
    for (i = 0; i < n ; i++) {
        for ( j = 0 ; j < n ; j++) {
            printf("Enter efficiency of employee %d for job %d (float value) ",(i+1),(j+1));
            scanf("%lf",&mat[i][j]);
        }
    }
    printf("\nThe matrix is:\n");
    for (i = 0; i < n ; i++) {
        for ( j = 0 ; j < n ; j++)
            printf("%lf ",mat[i][j]);
        printf("\n");
    }
    double cost = 10000.0;
    permute(arrForPerm,n,mat,0,n-1,&cost,res,&opCount);
    printf("\nCost : %lf\n",cost);
    for(i=0;i<n;i++)
        printf("Employee %d is given job %d\n",i+1,res[i]+1);
    printf("It took %d operations.\n",opCount);
}