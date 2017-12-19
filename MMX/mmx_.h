#pragma once

extern "C" int* add_up(
	const int* a,
	const int* b,
	int len,
	int* dst
);

extern "C" int* deduct(
	const int* a,
	const int* b,
	int len,
	int* dst
);

extern "C" void multiply(
	int* a,
	int len,
	long long n,
	int* dst
);

extern "C" void divide(
	int* a,
	int len,
	long long n,
	int* dst
);

extern "C" bool compare(
	int* a,
	int* b,
	int len
);

extern "C" bool compare_g(
	int* a,
	int* b,
	int len
);