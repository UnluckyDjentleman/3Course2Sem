#include"SchiferAlg.h"

std::map<char, int>SymbolDictionary(std::string text, std::string a) {
	std::map<char, int>ma;
	for (int i = 0; i < a.size(); i++) {
		for (int j = 0; j < text.size(); j++) {
			if (a[i] == text[j]&&!ma.count(a[i])) {
				ma.insert(std::make_pair(a[i], 1));
			}
			else if (a[i] == text[j] && ma.count(a[i])) {
				ma[a[i]] += 1;
			}
		}
	}
	return ma;
}

void OutputAppearances(std::map<char, int>ma, std::string text) {
	std::cout << "     Symbol     " << "|" << "     Appearance     " << std::endl;
	std::cout << "=====================================" << std::endl;
	for (auto elem = ma.begin(); elem != ma.end(); elem++) {
		std::cout << elem->first << "               " << "|" << (double)elem->second/text.size() << "    " << std::endl;
	}
}

std::string ReadTextFromFile(std::string fileName) {
	std::fstream inf("../Texts/" + fileName);
	std::string readTo;

	if (!inf.is_open()) {
		std::cerr << "Cannot read data from file!";
		exit(-1);
	}

	while (std::getline(inf, readTo)) {
		inf >> readTo; 
	}
	transform(readTo.begin(), readTo.end(), readTo.begin(),
		[](unsigned char c) { return std::tolower(c); });
	return readTo;
}

void WriteOnFile(std::string fileName, std::string encryptText) {
	std::ofstream onf("../Texts/" + fileName);
	if (!onf.is_open()) {
		std::cerr << "Cannot read data from file!";
		exit(-1);
	}
	onf << encryptText << std::endl;
	return;
}

int EuclidReference(int a, int N) {
	if (a < 1 || N < 2) {
		return -1;
	}
	int u1 = N;
	int u2 = 0;
	int v1 = a;
	int v2 = 1;
	while (v1 != 0) {
		int q = u1 / v1;
		int t1 = u1 - q * v1;
		int t2 = u2 - q * v2;
		u1 = v1;
		u2 = v2;
		v1 = t1;
		v2 = t2;
	}
	return u1 == 1 ? (u2 + N) % N : -1;
}

std::string CaesarSchifer(std::string text, int a, int b, std::string alph) {
	std::string out;
	std::clock_t time= std::clock();
	//This solution is for dumbs like me who never looks for easier solutions
	/*for (int i = 0; i < alph.size(); i++) {
		for (int j = 0; j < text.size(); j++) {
			if (alph[i] == text[j]) {
				int f = (i + 1);
				int u = ((a * f) + b) % alph.size();
				if (u != 0) {
					out[j] = alph[u - 1];
				}
				else {
					out[j] = alph[i];
				}
			}
		}
	}*/
	//There's easier solution
	for (auto c = text.begin(); c != text.end(); c++) {
		if (alph.find(*c) != -1) {
			int h = ((a * (alph.find(*c))) + b) % alph.size();
			out += alph[h];
		}
		else {
			out += *c;
		}
	}
	std::clock_t duration = (std::clock() - time);
	std::cout << "Time of Caesar encryption: " << duration << " ms";
	return out;
}

std::string Vigenere(std::string text, std::string alphabet, std::string baseString) {
	int key_length = 0;
	std::string xd;
	std::clock_t time = std::clock();
	for (auto c = text.begin(); c != text.end(); c++) {
		if (alphabet.find(*c) != -1) {
			int h = (alphabet.find(*c) + alphabet.find(baseString[key_length])) % alphabet.size();
			xd += alphabet[h];
			key_length += 1;
			if (key_length + 1 == baseString.size()) {
				key_length = 0;
			}
		}
		else {
			xd += *c;
		}
	}
	std::clock_t duration = (std::clock() - time);
	std::cout <<"Time of Vigenere encryption: " << duration<<" ms";
	return xd;
}

std::string VigenereDeschifer(std::string text, std::string alphabet, std::string baseString) {
	std::string xd;
	int key_length = 0;
	std::clock_t time = std::clock();
	for (auto c = text.begin(); c != text.end(); c++) {
		if (alphabet.find(*c) != -1) {
			int first = (alphabet.find(*c));
			int second = alphabet.find(baseString[key_length]);
			int h = ((first - second)+alphabet.size()) % alphabet.size();
			xd += alphabet[h];
			key_length += 1;
			if (key_length + 1 == baseString.size()) {
				key_length = 0;
			}
		}
		else {
			xd += *c;
		}
	}
	std::clock_t duration = (std::clock() - time);
	std::cout << "Time of Vigenere decryption: " << duration << " ms" << std::endl;
	return xd;
}

std::string CaesarDeschifer(std::string text, int a, int b, std::string alph) {
	std::string out;
	std::clock_t time=std::clock();
	for (auto c = text.begin(); c != text.end(); c++) {
		if (alph.find(*c) != -1) {
			int u = EuclidReference(a, alph.size());
			int e = (alph.find(*c));
			int h = (u * (e + alph.size() - b)) % alph.size();
			out += alph[h];
		}
		else {
			out += *c;
		}
	}
	std::clock_t duration = (std::clock() - time);
	std::cout << "Time of Caesar decryption: " << duration << " ms"<<std::endl;
	return out;
}

