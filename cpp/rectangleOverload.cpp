/* source: rectangleOverload.cpp
uses binary and unary operator
compile: g++ rectangleOverload.cpp
*/

#include <iostream>
using namespace std;

class Rectangle {
	private:
	double width, length;
	public:
	void setWidth(double w);
	void setLength(double l);
	double getLength(void) const;
	double getWidth(void) const;
	double getArea(void) const;
	Rectangle operator+(Rectangle b) const;
	Rectangle operator-() const;
};

void Rectangle::setWidth(double w) {
	width = w;
}

void Rectangle::setLength(double l) {
	length = l;
}

double Rectangle::getWidth() const {
	return width;
}

double Rectangle::getLength() const {
	return length;
}

double Rectangle::getArea() const {
	return width*length;
}

Rectangle Rectangle::operator+(Rectangle b) const {
	Rectangle rect;
	rect.length = this->length + b.length;
	rect.width = this->width + b.width;
	return rect;
}

Rectangle Rectangle::operator-() const {
	Rectangle rect;
	rect.length = -length;
	rect.width = -width;
	return rect;
}

int main() {
	Rectangle box1, box2, box3;
	box1.setWidth(5); box1.setLength(7);
	box2.setWidth(2); box2.setLength(6);
	box3 = box1+box2;

	cout << "Here is box1's data:" << endl;
	cout << "Width, Length: " << box1.getWidth() << "," << box1.getLength() << endl;
	cout << "Here is box2's data: " << endl;
	cout << "Width, Length: " << box2.getWidth() << "," << box2.getLength() << endl;

	cout << "Now, box3's data: " << endl;
	cout << "width, length: " <<  box3.getWidth() << "," << box3.getLength() << endl;
	
	cout << "Ok, heres -box2 data: " << endl;

	cout << "Width, length: " << -box2.getWidth() << "," << -box2.getLength() << endl;
	
	return 0;
}



