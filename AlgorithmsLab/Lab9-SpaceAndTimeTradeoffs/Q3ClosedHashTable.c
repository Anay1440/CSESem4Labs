#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define SIZE 50

typedef struct node {
    int key,val;
    struct node * next;
} Node;

Node * createNode(int x) {
    Node * new = (Node *) malloc(sizeof(Node));
    new->key = x;
    new->next = NULL;
    return new;
}

void insertHashTable(Node * hashTable[], int x) {
    int key = x % SIZE;
    while (hashTable[key] != NULL) {
        key = (key + 1) % SIZE;
    }
    hashTable[key] = createNode(x);
}

int getHashTable(Node * hashTable[], int x) {
    int key = x % SIZE;
    int i = key, count = 0;
    do {
        count++;
        if (hashTable[key] != NULL) {
            if (hashTable[key]->key == x) {
                return count; 
            }
        }
        key = (key + 1) % SIZE;
    } while (key != i);
    return -count;
}

void main() {
    Node * hashTable[SIZE];
    int i, x, comparisonsSuccess = 0, comparisonsFail = 0,countSuccess = 0, countFail = 0;
    time_t t;
    srand((unsigned) time(&t));

    for (i = 0; i < SIZE; i++) 
        hashTable[i] = NULL;

    for(i = 0; i < SIZE; i++) {
        x = rand() % 100;
        insertHashTable(hashTable, x);
    }
    
    for(i = 0; i < SIZE; i++) {
        x = rand() % 100;
        x = getHashTable(hashTable, x);
        if (x < 0) {
            comparisonsFail += -x;
            countFail += 1;
        }
        else {
            comparisonsSuccess += x;
            countSuccess += 1;
        }
    }
    if (countSuccess == 0 || countFail == 0)
        printf("Please rerun");
    else
        printf("Average number of key comparisons in successful search: %d\nAverage number of key comparisons in unsuccessful search: %d\n",(comparisonsSuccess/countSuccess),(comparisonsFail/countFail));

}