#include <stdio.h>
#include <stdlib.h>

void floydWarshall(int ** mat, int n) {
    int ** cost = (int **) malloc(n * sizeof(int *));
    int i, j, k, opCount = 0;
    for (i = 0; i < n; i++) {
        cost[i] = (int *) malloc(n * sizeof(int));
        for (j = 0; j < n; j++) {
            cost[i][j] = mat[i][j];
        }
    }
    for (k = 0; k < n; k++) {
        for (i = 0; i < n; i++) {
            for (j = 0; j < n; j++) {
                opCount++;
                if (cost[i][j] > cost[i][k] + cost[k][j])
                    cost[i][j] = cost[i][k] + cost[k][j];
            }
        }
    }
    for (i = 0; i < n; i++) {
        for (j = 0; j < n; j++) 
            printf("%d ",cost[i][j]);
        printf("\n");
    }
    printf("Opcount: %d\n",opCount);
}

void main() {

    int i, j, n;
    printf("Enter number of vertices ");
    scanf("%d",&n);

    int ** adjMat = (int **) malloc(n * sizeof(int *));

    for(i = 0; i < n; i++) 
        adjMat[i] = (int *) calloc(n,sizeof(int));
    
    for(i = 0; i < n; i++) {
        for(j = 0; j < n; j++) {
            printf("Enter a[%d][%d] ",i,j);
            scanf("%d",&adjMat[i][j]);
        }
    }

    floydWarshall(adjMat,n);

}