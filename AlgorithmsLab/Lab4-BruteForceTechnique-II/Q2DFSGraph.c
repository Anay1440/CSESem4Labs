#include <stdio.h>
#include <stdlib.h>
#include "GraphFuncs.h"

void dfs(Graph g, int x, int ind, int visited[], int *found) {

    if (*found == 1)
        return;

    if (g.nodes[ind].val == x) {
        printf("Value found in node %d\n",g.nodes[ind].index + 1);
        *found = 1;
        return;
    }
    visited[ind] = 1;
    Node * temp = (Node *) malloc(sizeof(Node));
    temp = g.adjLists[ind];
    
    while (temp != NULL) {
        int adjInd = temp->gNode.index;
        if (visited[adjInd] == 0)
            dfs(g,x,adjInd,visited,found);
        temp = temp -> next;
    }
}

void main() {
    int n,i,x,found = 0;
    printf("Enter number of nodes in graph ");
    scanf("%d",&n);
    int * visited = (int *) calloc(n,sizeof(int));
    Graph g = createGraph(n);
    printf("Enter value to search for ");
    scanf("%d",&x);
    dfs(g,x,0,visited,&found);
    if (found == 0)
        printf("Value not found in graph.\n");
}