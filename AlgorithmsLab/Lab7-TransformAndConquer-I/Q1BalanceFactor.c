#include <stdio.h>
#include <stdlib.h>

typedef struct node {
    int val;
    struct node * left;
    struct node * right;
} Node;

Node * createNode(int x) {
    Node * new = (Node *) malloc(sizeof(Node));
    new->val = x;
    new->left = NULL;
    new->right = NULL;
    return new;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int height(Node * root) {
    if (root == NULL)
        return 0;
    return 1 + max(height(root->left), height(root->right));
}

int balanceFactor(Node * root) {
    if (root == NULL)
        return 0;
    return height(root->left) - height(root->right);
}

void inOrder(Node *tree) {
    if (tree != NULL) {
        inOrder(tree->left);
        printf("Node with value %d has balance factor %d\n",tree->val,balanceFactor(tree));
        inOrder(tree->right);
    }
}

void insertBST(Node **tree,int x) {

    Node * temp = createNode(x);
    Node * prev = NULL;
    Node * iter = *tree;

    while (iter != NULL) {
        prev = iter;
        if (iter->val > x)
            iter = iter->left;
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

void main() {

    // To avoid manual input
    /*
    Node * root = createNode(5);
    root->left = createNode(3);
    root->left->left = createNode(2);
    root->left->right = createNode(4);
    root->right = createNode(8);
    root->right->left = createNode(6);
    root->right->left->right = createNode(7); */

    int n,i,x;
    Node * tree = NULL;
    printf("Enter number of elements ");
    scanf("%d",&n);
    printf("Enter elements:\n");
    for (i=0;i<n;i++) {
        printf("Enter element ");
        scanf("%d",&x);
        insertBST(&tree,x);
    }

    inOrder(tree);
}