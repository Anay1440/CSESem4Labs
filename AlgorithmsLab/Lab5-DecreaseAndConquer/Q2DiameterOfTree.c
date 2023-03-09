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

int diameter(Node * root, int * h) {
    if (root == NULL)
        return 0; 

    int lHeight = 0, rHeight = 0;

    int lDia = diameter(root->left, &lHeight);
    int rDia = diameter(root->right, &rHeight);

    *h = max(lHeight, rHeight) + 1;

    int temp = max(lDia, rDia);

    return max(lHeight + rHeight + 1, temp);

}

void main() {
    Node * root = createNode(1);
    root->left = createNode(2);
    root->right = createNode(3);
    root->left->left = createNode(4);
    root->left->right = createNode(5);
    root->right->right = createNode(6);
    root->left->right->left = createNode(7);
    root->left->right->right = createNode(8);
    root->right->right->right = createNode(9);
    root->right->right->right->left = createNode(10);
    root->right->right->right->right = createNode(11);
    root->right->right->right->left->left = createNode(12);
    root->right->right->right->left->right = createNode(13);
    int height = 0;
    printf("Diameter of the given binary tree is %d\n",diameter(root,&height));
}