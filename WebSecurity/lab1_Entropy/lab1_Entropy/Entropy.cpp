#include"Entropy.h"

using namespace std;

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
	for (auto iter = symbolica.begin(); iter!=symbolica.end(); ++iter) {
		double temp = (double)(iter->second) / str.size();
		entropy -= temp*log2(temp);
	}
	return entropy;
}

bool IsBinaryAlphabet(string alphabet) {
	return CountSymbolsInText(alphabet).size() == 2&&(CountSymbolsInText(alphabet).count('1')&& CountSymbolsInText(alphabet).count('0'));
}

double EffectiveEntropy(string str, double p) {
	double q = 1 - p;
	if (IsBinaryAlphabet(str) && (p == 0 || q == 0)) {
		return 1;
	}
	else if (!IsBinaryAlphabet(str) && p == 1) {
		return 0;
	}
	return 1 -( - p * log2(p) - q * log2(q));
}

double InfoAmount(std::string alphabet, string str) {
	return IsBinaryAlphabet(alphabet)?str.size(): ShannonEntropy(alphabet) * str.size();
}

double InfoAmount(std::string alphabet, string str, double p) {
	return ShannonEntropy(alphabet) * str.size() * EffectiveEntropy(alphabet, p);
}

string InfoFromFile(string fileName) {
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