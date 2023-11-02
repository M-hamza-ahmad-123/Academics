#include<iostream>
using namespace std;
int main()
{


	int numOfItems;
	double unitCost;
	try
	{
		cout << "Enter the number of items: ";
		cin >> numOfItems;
		cout << endl;
		if (numOfItems < 0)
			throw numOfItems;
		cout << "Enter the cost of one item: ";
		cin >> unitCost;
		cout << endl;
		if (unitCost < 0)
			throw unitCost;
		cout << "Total cost: $"
			<< numOfItems * unitCost << endl;
	}
	catch (int num)
	{
		cout << "Negative number of items: " << num
			<< endl;
		cout << "Number of items must be nonnegative."
			<< endl;
	}
	catch (double dec)
	{
		cout << "Negative unit cost: " << dec
			<< endl;
		cout << "Unit cost must be nonnegative."
			<< endl;
	}
}




// Answer1 : 137.5$.
// Answer2 : Number of items must be nonnegatve.
// Answer3 : Unit must be nonnegative.
// Answer4 : Numer of items must be nonnegative.