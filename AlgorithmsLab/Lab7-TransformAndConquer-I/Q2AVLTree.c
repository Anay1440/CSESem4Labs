#include <stdio.h>
#include <stdlib.h>

#define max(a,b) (((a) > (b)) ? (a) : (b))

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

Node * rightRotate(Node * root) {
    Node * temp = (Node *) malloc(sizeof(Node));
    Node * temp2 = (Node *) malloc(sizeof(Node));   //         root       --->      temp
                                                    //         /  \                 /   \          //
    temp = root->left;                              //     temp    y               x   root
    temp2 = temp -> right;                          //     /   \                       /  \        //
                                                    //    x   temp2                temp2   y
    temp -> right = root;
    root->left = temp2;
    
    return temp;
}

Node * leftRotate(Node * root) {
    Node * temp = (Node *) malloc(sizeof(Node));
    Node * temp2 = (Node *) malloc(sizeof(Node));   //        root       --->      temp
                                                    //        /  \                 /   \         //
    temp = root->right;                             //       y  temp             root   x
    temp2 = temp -> left;                           //          /  \             /  \            //
                                                    //      temp2   x           y   temp2
    temp -> left = root;
    root->right = temp2;
    
    return temp;
}

void inOrder(Node *tree) {
    if (tree != NULL) {
        inOrder(tree->left);
        printf("%d ",tree->val);
        inOrder(tree->right);
    }
}

void insertBST(Node **tree,int x) {

    Node * temp = createNode(x);
    Node * prev = NULL;
    Node * preprev = NULL;
    Node * superpre = NULL;
    Node * iter = *tree;

    while (iter != NULL) {
        superpre = preprev;
        preprev = prev;
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

    int balance = balanceFactor(preprev);

    // Left Left
    if (balance > 1 && x < preprev->left->val) {
        if(preprev == *tree) 
            *tree = rightRotate(preprev);
        else {
            preprev = rightRotate(preprev);
            superpre->left = preprev;
        }
    }

    // Right Right
    else if (balance < -1 && x > preprev->right->val) {
        if(preprev == *tree)
            *tree = leftRotate(preprev);
        else {
            preprev = leftRotate(preprev);
            superpre->right = preprev;
        }
    }
 
    // Left Right
    else if (balance > 1 && x > preprev->left->val) {
        preprev->left = leftRotate(preprev->left);
        if(preprev == *tree)
            *tree = rightRotate(preprev);
        else {
            preprev = rightRotate(preprev);
            superpre->left = preprev;
        }
    }
 
    // Right Left
    else if (balance < -1 && x < preprev->right->val) {
        preprev->right = rightRotate(preprev->right);
        if(preprev == *tree)
            *tree = leftRotate(preprev);
        else {
            preprev = leftRotate(preprev);
            superpre->right = preprev;
        }
    }    
}

int main() {
    int n,i,x;
    Node * tree = (Node *) malloc(sizeof(Node));
    tree = NULL;
    printf("Enter number of elements ");
    scanf("%d",&n);
    printf("Enter elements:\n");
    for (i=0;i<n;i++) {
        printf("Enter element ");
        scanf("%d",&x);
        insertBST(&tree,x);
    }
    printf("Inorder traversal: ");
    inOrder(tree);
}