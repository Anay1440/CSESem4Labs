#include <stdio.h>
#include <stdlib.h>

typedef struct node {
	struct node * right;
	struct node * left;
	int val;
} Node;

Node * createNode(int x) {
	Node * new = (Node *) malloc(sizeof(Node));
	new->val = x;
	new->right = NULL;
	new->left = NULL;
	return new;
}

void insertBST(Node **tree,int x) {
    Node * iter = (Node *) malloc(sizeof(Node));
    Node * prev = (Node *) malloc(sizeof(Node));
    Node * root = (Node *) malloc(sizeof(Node));
    Node * temp = (Node *) malloc(sizeof(Node));
    
    temp = createNode(x);
    prev = NULL;
    root = *tree;
    iter = root;
    while (iter != NULL) {
        prev = iter;
        if (iter->val > x)
            iter = iter->left;
        else if (iter->val == x) {
        	printf("Key found\n");
        	return;
        }
        else
            iter = iter->right;
    }
    if (prev == NULL) 
        *tree = temp;
    else if (x < prev->val) 
        prev->left = temp;
    else 
        prev->right = temp;
}

void preOrder(Node * root) {
	if (root != NULL) {
		printf("%d ",root->val);
		preOrder(root->left);
		preOrder(root->right);
	}
}

void inOrder(Node * root) {
	if (root != NULL) {
	inOrder(root->left);
	printf("%d ",root->val);
	inOrder(root->right);
	}
}

void postOrder(Node * root) {
	if (root != NULL) {
		postOrder(root->left);
		postOrder(root->right);
		printf("%d ",root->val);	
	}
}

void main() {
	printf("Enter BST elements. Type -1 to exit.\n");
	int x;
	Node * root = (Node *) malloc(sizeof(Node));
	root=NULL;
	do {
		printf("Enter element ");
		scanf("%d",&x);
		if (x < 0)
			break;
		insertBST(&root,x);
	}
	while(x != -1);
	printf("\nPreOrder: ");
	preOrder(root);
	printf("\nInOrder: ");
	inOrder(root);
	printf("\nPostOrder: ");
	postOrder(root);
}