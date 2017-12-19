// MMX.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"
#include <iostream>
#include <sstream>
#include <string>
#include <vector>
#include "mmx_.h"

using namespace std;
using std::string;
using std::vector;

void print(string text, int* arr, int length);

int main()
{
	string input;
	vector<int> a;
	vector<int> b;
	
	const int len = 16;
	
	int32_t dst[len];

	// Input
	int n;
	cout << "Enter A: ";
	std::stringstream iss;
	getline(cin, input);
	iss << input;
	while (iss >> n)
		a.push_back(n);

	cout << "Enter B: ";
	iss.clear();
	getline(cin, input);
	iss << input;
	while (iss >> n)

		b.push_back(n);
	print("A = ", a.data(), a.size()); 
	print("B = ", b.data(), b.size());
	//-------
	
	add_up(a.data(), b.data(), (a.size()+1)/2, dst);
	print("A + B = ", dst, a.size());

	deduct(a.data(), b.data(), (a.size() + 1) /2, dst);
	print("A - B = ", dst, a.size());

	cout << "Enter the power of 2, n: ";
	cin >> n;
	
	multiply(a.data(), (a.size() + 1) / 2, n, dst);
	print("A * 2^n = ", dst, a.size());

	divide(a.data(), (a.size() + 1) / 2, n, dst);
	print("A / 2^n = ", dst, a.size());

	cout << "A == B: " << compare(a.data(), b.data(), (a.size() + 1) / 2) << "\n";
	cout << "A > B: " << compare_g(a.data(), b.data(), (a.size() + 1) / 2) << "\n";;

	system("pause");
    return 0;
}

void print(string text, int* arr, int length)
{
	cout << text;
	for (int i = 0; i < length; i++)
	{
		cout << arr[i] << " ";
	}
	cout << "\n";
}