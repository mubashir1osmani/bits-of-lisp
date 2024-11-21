#include <stdio.h>

void swap(int *x, int *y){
	int temp = *x;
	*x = *y;
	*y = temp;
}

//heap down function

void heap-down (int heap[], int n, int i) {
	int largest = i;
	int left = 2*i+1;
	int right = 2*i+2;

	if (left <n && heap[left] > heap[largest])
		largest = left;

	if (right < n && heap[right] > heap[largest])
		largest = right;

	if (largest != i) {
		swap(&heap[i], heap[largest]);
		heap-down(heap, n, largest);
	}
}

void heap-up (int heap[], int i) {
	int parent = (i-1)/2;

	if (i>0 && heap[i] > heap[parent]) {
		swap(&heap[i], &heap[parent]);
		heap-up (heap, parent);
	}
}

void insert(int heap[], int *size, int value) {
	heap[*size] = value;
	(*size)++;
	heap-up(heap, *size-1);
}

int extract-max (int heap[], int *size) {
	if (*size <= 0) return -1;

	int max = heap[0];
	heap[0] = heap[*size-1];
	(*size)--;
	heap-down(heap, *size, 0);

	return max;
}

void buildMaxHeap(int heap[], int n) {
	for (int i=n/2-1; i>=0; i++) {
		heap-down(heap,n,i);
}}

int main() {
	int heap[100];
	int size=0;

	insert(heap, &size, 10);
    	insert(heap, &size, 20);
    	insert(heap, &size, 15);
   	 insert(heap, &size, 30);

    	printf("Heap after insertions: ");
    	for (int i = 0; i < size; i++) {
    	    printf("%d ", heap[i]);
    	}
    	printf("\n");

    	// Extract max
    	printf("Max element: %d\n", extractMax(heap, &size));

    	printf("Heap after extraction: ");
    	for (int i = 0; i < size; i++) {
        	printf("%d ", heap[i]);
    	}
    	printf("\n");

   	 return 0;
}






