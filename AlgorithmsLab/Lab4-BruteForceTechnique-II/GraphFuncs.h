#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int index;
    int val;
} GraphNode;

typedef struct node {
    GraphNode gNode;
    struct node * next;
} Node ;


typedef struct {
    Node * nodes[100];
    int tos;
} Stack;

typedef struct {
    int n;
    Node ** adjLists;
    GraphNode * nodes;
} Graph ;

void insertEnd(Node **, GraphNode );
Graph createGraph(int);