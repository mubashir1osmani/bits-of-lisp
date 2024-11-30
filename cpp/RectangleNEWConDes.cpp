#include <iostream>

using namespace std;

class Rectangle {
	private:
	double width, length;
	
	public:
	Rectangle();
	Rectangle(double, double);
	~Rectangle();
	void setWidth(double w);
	void setLength(double l);
	double getWidth(void) const;
	double getLength(void) const;
	double getArea(void) const;

};

Rectangle::Rectangle() { width=0; length=0; }
Rectangle::Rectangle(double w, double l) {
	width=w;
	length=l;
}

Rectangle::~Rectangle() {
	cout << "Object deleted\n";
}

void Rectangle::setWidth(double w) {
	width = w;
}

void Rectangle::setLength(double l) {
	length = l;
}

double Rectangle::getWidth() const {
	return width;
}

double Rectangle::getLength()  const {
	return length;
}

double Rectangle::getArea() const {
	return width*length;
}

int main() {
	Rectangle *boxptr;
	
	double rectWidth, rectLength;
	cout << "this program calculates the area of a rectangle: \n";
	cout << "What's the width?: \n";
	cin >> rectWidth ;
	cout << "What's the length?: \n";
	cin >> rectLength ;

	boxptr = new Rectangle;
	boxptr->setWidth(rectWidth);
	boxptr->setLength(rectLength);

	cout << "Here's your data!!: " << endl ;
	cout << "Width: " <<  boxptr->getWidth() << endl;
	cout << "Length: " << boxptr->getLength() << endl;
	cout << "Area: " << boxptr->getArea() << endl;

	delete boxptr;
	boxptr = NULL;
	return 0;
}	
