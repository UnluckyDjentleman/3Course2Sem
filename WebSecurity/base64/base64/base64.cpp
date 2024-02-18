#include "base64.h"

string ReadTextFromFile(string fileName) {
	ifstream inf("../Texts/" + fileName);
	string readTo;

	if (!inf) {
		cerr << "Cannot read data from file!";
		exit(-1);
	}
	while (getline(inf, readTo)) {
		inf >> readTo;
	}
	transform(readTo.begin(), readTo.end(), readTo.begin(),
		[](unsigned char c) { return std::tolower(c); });

	return readTo;
}

map<char, int> CountSymbolsInText(string str) {
	map<char, int>symbolsDictionary;
	for (int i = 0; i < str.size(); i++) {
		if (!symbolsDictionary.count(str[i])) {
			symbolsDictionary.insert(make_pair(str[i], 1));
		}
		else {
			symbolsDictionary[str[i]] += 1;
		}
	}
	return symbolsDictionary;
}
double ShannonEntropy(string str) {
	map<char, int>symbolica = CountSymbolsInText(str);
	double entropy = 0.0;
	for (auto iter = symbolica.begin(); iter != symbolica.end(); ++iter) {
		double temp = (double)(iter->second) / str.size();
		entropy -= temp * log2(temp);
	}
	return entropy;
}

double HartleyEntropy(string str) {
	return log2(str.size());
}

double GetRedunancy(double x, double y) {
	return (x - y) / x;
}

int CodeAt(char c) {
	return (int)c;
}

string TextToBase64(string str) {
	//this shit could be lower, 
	string base64chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
	string a, b;
	int mod = str.size() % 3;
	//making a str multiple to 3 for encoding to base64
	if (mod > 0) {
		for (; mod < 3; mod++) {
			a +=  '=';
			str += '\0';
		}
	}
	mod = 0;
	while(mod<str.size()) {
		if (mod > 0 && (mod / 3 * 4) % 76 == 0) {
			b += '\r\n';
		}
		unsigned long n = (CodeAt(str[mod]) << 16) + (CodeAt(str[mod+1]) << 8) + CodeAt(str[mod+2]);
		b += string() + base64chars[(n >> 18) & 63] + base64chars[(n >> 12) & 63] + base64chars[(n >> 6) & 63] + base64chars[n & 63];
		mod += 3;
	}
	return b.substr(0,b.size() - a.size()) + a;
}

string Xor(string a, string b) {
	string resultBit, result;
	cout << "First string:" << a << endl;
	cout << "Second string:" << b << endl;
	if (a.size() > b.size()) {
		while (a.size() != b.size()) {
			b += '\0';
		}
	}
	else if (a.size() < b.size()) {
		while(a.size()!=b.size()){
			a += '\0';
		}
	}
	for (int i = 0; i < b.size(); i++) {
		bitset<8>c1(a[i]);
		bitset<8>c2(b[i]);
		resultBit += (c1 ^ c2).to_string();
		result += char((c1 ^ c2).to_ulong());
	}
	cout << "Binary Result: " << resultBit << endl;
	cout << "Result: ";
	return result;
}
