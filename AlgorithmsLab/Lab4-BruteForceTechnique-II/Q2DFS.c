#include <stdio.h>
#include <stdlib.h>
#include "GraphFuncs.h"

void push(Stack *s, GraphNode n) {
    (s->nodes)[++(s->tos)] = n;
}

GraphNode pop(Stack *s) {
    return s->nodes[(s->tos)--];
}

void dfs(Graph g, int x, int visited[]) {
    Stack s;
    s.tos = -1;
    int ind = 0;
    Node * temp = (Node *) malloc(sizeof(Node));
    GraphNode gtemp;

    push(&s,g.nodes[0]);
    visited[0] = 1;
    while (s.tos != -1) {
        gtemp = pop(&s);
        printf("Node %d popped at position %d\n",gtemp.index + 1,ind++);
        if (gtemp.val == x) {
            printf("Value found at node %d\n",gtemp.index+1);
            return;
        }
        temp = g.adjLists[gtemp.index];
        while (temp != NULL) {
            if (visited[temp->gNode.index] == 0) {
                push(&s,temp->gNode);
                printf("Node %d pushed to stack\n",temp->gNode.index + 1);
                visited[temp->gNode.index] = 1;
            }
            temp = temp -> next;
        }
    }
    printf("Value not found.\n");
}

void main() {
    int n,x;
    printf("Enter number of nodes in graph ");
    scanf("%d",&n);
    int * visited = (int *) calloc(n,sizeof(int));
    Graph g = createGraph(n);
    printf("Enter value to search for ");
    scanf("%d",&x);
    dfs(g,x,visited);
}