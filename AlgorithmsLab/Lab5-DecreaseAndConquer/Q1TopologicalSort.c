#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int arr[100];
    int tos;
} Stack;

typedef struct {
    int n;
    int ** adjLists;
} Graph ;

void push(Stack *s, int n) {
    (s->arr)[++(s->tos)] = n;
}

void insertEnd(int * list, int n) {
    int i = 0;
    while (list[i] != -1)
        i++;
    list[i] = n;
    list[i+1] = -1;
}


Graph createDAG(int n) {
    Graph g;
    g.n = n;
    int i,x,j;
    g.adjLists = (int **) malloc (n * sizeof(int *));
    for (i = 0; i < n; i++) {
        g.adjLists[i] = (int *) malloc(n * sizeof(int));
        g.adjLists[i][0] = -1;
    }
    for(i=0;i<n;i++) {
		for(j=0;j<n;j++) {
			if (i==j) 
				continue;
			else {
                printf("Is there an edge from vertex %d to vertex %d ? Type 1 if yes, 0 if no ", i, j);
                scanf("%d",&x);
                if (x == 1) 
                    insertEnd((g.adjLists[i]),j);
			}
		}
	}
    return g;
}

void topoDFS(Graph g, int * visited, Stack * s ,int ind) {
        
    visited[ind] = 1;
    int * list = g.adjLists[ind];
    int i = 0;
    while (list[i] != -1) {
        if (visited[list[i]] == 0)
            topoDFS(g, visited, s, ind+1);
        i++;
    }
    push(s,ind);
    
}

int in(int arr[], int n, int x) {
    int i;
    for (i = 0; i < n; i++) 
        if (arr[i] == x)
            return 1;
    return 0;
}

void topoSourceRem(Graph * g, int * removed, int * ind) {
    int i,j, *list, min = 1000;
    int * degree = (int *) calloc((g->n) , sizeof(int));
    for(i = 0; i < g -> n; i++) {
        j = 0;
        list = g->adjLists[i];
        if (!in(removed,*ind,i)) {
            while (list[j] != -1) {
                if (!in(removed,*ind,list[j]))
                    degree[list[j]]++;
                j++;
            }    
        }
        else {
            degree[i] = -1;
        }
    }
    for (i = 0; i < g -> n; i++) {
        if (degree[i] == -1)
            continue;
        if (degree[i] < min) {
            min = degree[i];
            j = i;
        }
    }
    removed[*ind] = j;
    *ind = *ind + 1;
    printf("%d ", j);

}

void main() {
    int n,x,i;

    // printf("Enter number of nodes in graph ");
    // scanf("%d",&n);
    // int * visited = (int *) calloc(n,sizeof(int));
    // int * removed = (int *) calloc(n,sizeof(int));
    // int ind = 0;
    // Graph g = createDAG(n);

    // TO AVOID MANUAL INPUT : 

    n = 6;
    Graph g;
    g.n = 6;
    g.adjLists = (int **) malloc (n * sizeof(int *));
    for (i = 0; i < n; i++) {
        g.adjLists[i] = (int *) calloc(n , sizeof(int));
        g.adjLists[i][0] = -1;
    }
    g.adjLists[2][0] = 3;
    g.adjLists[2][1] = -1;
    g.adjLists[3][0] = 1;
    g.adjLists[3][1] = -1;
    g.adjLists[4][0] = 0;
    g.adjLists[4][1] = 1;
    g.adjLists[4][2] = -1;
    g.adjLists[5][0] = 0;
    g.adjLists[5][1] = 2;
    g.adjLists[5][2] = -1;

    int visited[6];
    int removed[6];
    int ind = 0;
    for(i=0;i<n;i++)
        visited[i] = 0; 

    Stack s;
    s.tos = -1;
    printf("Topological sort using DFS: ");
    for (i= 0; i < n ; i++)
        if (visited[i] == 0)
            topoDFS(g,visited,&s,i);
    while (s.tos != -1) 
        printf("%d ",(s.arr[s.tos--]));

    printf("\nToplogical sort using source removal: ");

    for (i = 0; i < n; i++) 
        topoSourceRem(&g,removed,&ind);
    
    printf("\n");
}