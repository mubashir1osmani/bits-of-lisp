#include <iostream>
#include <vector>

using namespace std;

int main() {
	vector <int> myVector;
	//myVector.reserve(50)
	
	vector <int>::iterator startIter;
	
	for (int i=0; i<10; i++) {
	myVector.push_back(i);
	cout << myVector[i] << endl ;
	cout << "capacity: " << myVector.capacity() << endl;
	}

	cout << "capacity=" << myVector.capacity() << " and size= " << myVector.size() << endl;

	cout << endl << "Print vector using a range-based loop:" << endl;
	for (auto& x:myVector)
		cout << x << " ";
	cout << endl;

	cout << "\nAdding 99 into position 1..." << endl;
