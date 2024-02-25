#include"NumbersTheory.h"

int GCD(int a, int b) {
	if (a == 0) {
		return b;
	}
	else if (b == 0) {
		return a;
	}
	else if (a == 1 || b == 1) {
		return 1;
	}
	while (a != 0 && b != 0) {
		if (a > b) {
			a -= b;
		}
		else {
			b -= a;
		}
	}
	return (a > b) ? a : b;
}

double GetApproximativeCountOfPrimes(int n) {
	return n / log(n);
}

int GetConcatenatedNumber(int n, int m) {
	string nStr = to_string(n);
	string mStr = to_string(m);
	return stoi(nStr + mStr);
}

bool IsPrime(int n) {
	if (n < 2) {
		return false;
	}
	for (int i = 2; i * i <= n; i++) {
		if (n % i == 0) {
			return false;
		}
	}
	return true;
}

vector<int>GetPrimes(int n) {
	vector<int>vec;
	for (int i = 2; i < n; i++) {
		if (IsPrime(i)) {
			vec.push_back(i);
		}
	}
	return vec;
}

vector<int>GetPrimes(int m, int n) {
	if (m > n) {
		swap(m, n);
	}
	vector<int>vec;
	for (int i = m; i < n; i++) {
		if (IsPrime(i)) {
			vec.push_back(i);
		}
	}
	return vec;
}

string Print(vector<int>a) {
	string str = "";
	for (int i = 0; i < a.size(); i++) {
		str += (to_string(a[i]) + " ");
	}
	return str + "\nCount of elements: " + to_string(a.size())+"\n";
}

vector<int> CanonicalForm(int par) {
	vector<int>canon;
	int div = 2;
	while (par > 1) {
		while (par % div == 0) {
			canon.push_back(div);
			par /= div;
		}
		div++;
	}
	return canon;
}

string PrintCanonicalForm(vector<int>a) {
	string str = "";
	for (int i = 0; i < a.size(); i++) {
		if (i == a.size() - 1) {
			str += to_string(a[i]);
			return str;
		}
		str += (to_string(a[i])+"*");
	}
	return str;
}