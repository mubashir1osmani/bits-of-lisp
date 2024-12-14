#include <iostream>
using namespace std;

class Node {
	public:
	int item;
	Node *next;

	Node() {
		item=0;
		next=NULL;
	}

	Node(int item) {
		this->item = item;
		this->next = NULL;
	}
};

class LinkedList {
	Node *head;
	
	public:
	LinkedList() {
		head = NULL;
	}

	void addToFront(int item) {
		Node *newNode = new Node(item);
	
	if (head == NULL) {
		head = newNode;
		return;
	}

	// if list not empty, insert at next
	
	newNode->next = this->head;
	this->head = newNode;
}

	void print() {
		Node *temp = head;
	
	// if list empty print NULL

	if (temp == NULL) {
		cout << "NULL" ;
		return;
	}

	while (temp != NULL) {
		cout << temp->item << " ";
		temp = temp->next;
	}
}
};


int main() {
	LinkedList mylist;
	
	cout << "my list is: ";
	mylist.print();
	cout << endl;

	mylist.addToFront(4);
	mylist.addToFront(3);
	mylist.addToFront(7);

	//print again

	cout << "my list is: ";
	mylist.print();
	cout << endl;

	return 0;
}




