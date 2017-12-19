// FPU17.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"
#include "iostream"
#define _USE_MATH_DEFINES
#include "cmath"
#include <math.h>
#include "fpu.h"

using namespace std;
int main()
{
	float x, e = 0.01;
	int n;
	cout << "Enter x: ";
	cin >> x;
	cout << "Enter n: ";
	cin >> n;
	cout << "Enter e: ";
	cin >> e;

	//cout << "Exact result = " << (pow(M_E, x)+ pow(M_E, -x))/2 << "\n";
	cout << "F(x, n) = " << fn(x, n) << "\n";
	cout << "F(x, eps) = " << fe(x, e) << "\n";
	cout << "Exact result = " << f_actual(x) << "\n";
	system("pause");
    return 0;
}

