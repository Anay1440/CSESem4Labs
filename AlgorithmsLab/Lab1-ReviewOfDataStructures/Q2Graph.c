#include <stdio.h>
#include <stdlib.h>

typedef struct node {
	struct node * next;
	int val;
} Node;

void display(Node * list) {
	while(list != NULL) {
		printf("Vertex %d -> ", list->val);
		list = list -> next;
	}
	printf("\n");
}

void insertLast(Node ** list, int x) {
	Node * new = (Node * ) malloc(sizeof(Node));
	Node * iter = (Node * ) malloc(sizeof(Node));
	iter = *list;
	while (iter->next != NULL)
		iter = iter->next;
	new->val = x;
	new->next = NULL;
	iter->next = new;
}

void main() {
	int v,x,i,j;
	printf("Enter the number of vertices ");
	scanf("%d",&v);
	int ** adjMat = (int **) calloc(v,sizeof(int *)); 
	Node ** adjLists = (Node **) calloc(v,sizeof(Node *));
	for(i=0;i<v;i++) {
		adjMat[i] = (int *) calloc(v,sizeof(int));
		adjLists[i] = (Node *) malloc(sizeof(Node));
		adjLists[i]->val = i+1;
		adjLists[i]->next = NULL;
	}

	for(i=0;i<v;i++) {
		for(j=0;j<v;j++) {
			if (i==j) 
				adjMat[i][i] = 0;
			else {
				if (adjMat[i][j] != 1 && adjMat[i][j] != -1) {
					printf("Is vertex %d connected to vertex %d ? Type 1 if yes, 0 if no ", (i+1), (j+1));
					scanf("%d",&x);
					if (x == 1) {
						insertLast(&(adjLists[i]),(j+1));
						insertLast(&(adjLists[j]),(i+1));
						adjMat[i][j] = 1;
						adjMat[j][i] = 1;
					}
					else {
						adjMat[i][j] = -1;
						adjMat[j][i] = -1;
					}
				}
			}
		}
	}
	printf("Adjacency Lists:\n");
	// for(i=0;i<v;i++) {
	// 	printf("\nVertex %d -> ",(i+1));
	// 	for(j=0;j<v;j++) {
	// 		if (adjMat[i][j] == 1)
	// 			printf("Vertex %d -> ",(j+1));
	// 	}
	// }
	for(i=0;i<v;i++)
		display(adjLists[i]);
	printf("\nAdjacency Matrix is:\n");
	for(i=0;i<v;i++) {
		for(j=0;j<v;j++) {
			if (adjMat[i][j] == -1)
				adjMat[i][j] = 0;
			printf("%d ", adjMat[i][j]);
		}
		printf("\n");
	}
}