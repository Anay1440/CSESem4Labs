#include <stdio.h>
#include <stdlib.h>
#include "GraphFuncs.h"

void enQueue(Queue * q, GraphNode n) {
    if (q->front == -1)
        q->front = 0;
    q->nodes[++(q->rear)] = n;
}

GraphNode deQueue(Queue *q) {
    GraphNode tempNode = q->nodes[(q->front)++];
    if (q->front > q->rear) {
        q->front = -1;
        q->rear = -1;
    }
    return tempNode;
}

void bfs(Graph g, int x, int visited[]) {

    Queue q;
    q.nodes = (GraphNode *) malloc(g.n * sizeof(GraphNode));
    q.front = -1;
    q.rear = -1;
    int ind = 0;
    Node * temp = (Node *) malloc(sizeof(Node));
    GraphNode gtemp;

    enQueue(&q,g.nodes[0]);
    visited[0] = 1;
    while (q.front != -1) {
        gtemp = deQueue(&q);
        printf("Node %d dequeued at position %d\n",gtemp.index + 1,ind++);
        if (gtemp.val == x) {
            printf("Value found at node %d\n",gtemp.index+1);
            return;
        }
        temp = g.adjLists[gtemp.index];
        while (temp != NULL) {
            if (visited[temp->gNode.index] == 0) {
                enQueue(&q,temp->gNode);
                visited[temp->gNode.index] = 1;
            }
            temp = temp -> next;
        }
    }
    printf("Value not found.\n");
}

void main() {
    int n,i,x,found = 0;
    printf("Enter number of nodes in graph ");
    scanf("%d",&n);
    int * visited = (int *) calloc(n,sizeof(int));
    Graph g = createGraph(n);
    printf("Enter value to search for ");
    scanf("%d",&x);
    bfs(g,x,visited);
}