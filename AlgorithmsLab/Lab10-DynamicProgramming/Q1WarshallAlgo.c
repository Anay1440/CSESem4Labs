#include <stdio.h>
#include <stdlib.h>

int warshall(int ** mat, int n, int c, int * opCount) {
    int i,j,flag;

    if (c == n) {
        for(i = 0; i < n; i++) {
            flag = 1;
            for(j = 0; j < n; j++) {
                (*opCount)++;
                if (mat[i][j] == 0)
                    flag = 0;
            }
            if (flag == 1)
                return 1;
        }
        return 0;
    }

    int ** r = (int **) malloc(n * sizeof(int *));

    for(i = 0; i < n; i++) 
        r[i] = (int *) calloc(n,sizeof(int));
    
    for(i = 0; i < n; i++) {
        for(j = 0; j < n; j++) {
            (*opCount)++;
            if ((mat[i][j] == 1) || (mat[i][c] == 1 && mat[c][j] == 1))
                r[i][j] = 1;
        }
    }

    return warshall(r, n, c+1, opCount);

}

void main() {

    int i, j, n, opCount = 0;
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

    if (warshall(adjMat,n,0, &opCount) == 1) 
        printf("The matrix exhibits transitive closure.\nOpcount: %d\n",opCount);
    else
        printf("The matrix does not exhibit transitive closure.\nOpcount: %d\n",opCount);

}
