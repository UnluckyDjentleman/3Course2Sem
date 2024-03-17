#include"Header.h"

#pragma region Menu
std::map<char, int>Menu::SymbolAppearances(std::string text) {
	std::map<char, int>symbolsDictionary;
	for (int i = 0; i < text.size(); i++) {
		if (!symbolsDictionary.count(text[i])) {
			symbolsDictionary.insert(std::make_pair(text[i], 1));
		}
		else {
			symbolsDictionary[text[i]] += 1;
		}
	}
	return symbolsDictionary;
}
std::string Menu::ReadFromFile(std::string fileName) {
	std::fstream inf("../Texts/" + fileName);
	std::string readTo;

	if (!inf) {
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
void Menu::WriteOnFile(std::string fileName, std::string text) {
	std::ofstream onf("../Texts/" + fileName);
	if (!onf.is_open()) {
		std::cerr << "Cannot read data from file!";
		exit(-1);
	}
	onf << text << std::endl;
	return;
}
#pragma endregion

#pragma region RouteSwapTable
RouteSwap::RouteSwap() {
}
std::string RouteSwap::matrixRouteEncrypt(int N, int M, std::string str) {
	char** a = new char* [N];
	for (int i = 0; i < N; i++) {
		a[i] = new char[M];
	}
	int k = 0, m=0;
	for (int i = 0; i < N; i++) {
		for (int j = 0; j < M; j++) {
			a[i][j] = str[k];
			k++;
		}
	}
	int i = 0;
	int j = 0;
	int iBeg = 0;
	int jBeg = 0;
	int jFin = 0;
	int iFin = 0;
	//うずまき
	std::clock_t time = std::clock();
	std::string encryptedText;
	while (N * M > m) {
		encryptedText += a[i][j];
		a[i][j] = str[m];
		if (i == iBeg && j < M - jFin - 1) {
			++j;
		}
		else if (j == M - jFin - 1 && i < N - iFin - 1) {
			++i;
		}
		else if (i == N - iFin - 1 && j > jBeg) {
			--j;
		}
		else --i;

		if ((i == iBeg + 1) && (j == jBeg) && (jBeg != M - jFin - 1)) {
			++iBeg;
			++iFin;
			++jBeg;
			++jFin;
		}
		++m;
	}
	for (int i = 0; i < N; i++) {
		delete[] a[i];
	}
	delete[] a;
	std::clock_t duration = (std::clock() - time);
	std::cout << "Time of Uzumaki route encryption: " << duration << " ms" << std::endl;
	return encryptedText;
}

std::string RouteSwap::matrixRouteDecrypt(int N, int M, std::string str) {
	std::string decryptText;
	char** a = new char* [N];
	for (int i = 0; i < N; i++) {
		a[i] = new char[M];
	}
	int k = 0, m = 0;
	int i = 0;
	int j = 0;
	int iBeg = 0;
	int jBeg = 0;
	int jFin = 0;
	int iFin = 0;
	if (str.size() < N * M) {
		str += '\0';
	}
	//うずまき
	std::clock_t time = std::clock();
	while (N * M > m) {
		a[i][j] = str[m];
		if (i == iBeg && j < M - jFin - 1) {
			++j;
		}
		else if (j == M - jFin - 1 && i < N - iFin - 1) {
			++i;
		}
		else if (i == N - iFin - 1 && j > jBeg) {
			--j;
		}
		else --i;

		if ((i == iBeg + 1) && (j == jBeg) && (jBeg != M - jFin - 1)) {
			++iBeg;
			++iFin;
			++jBeg;
			++jFin;
		}
		++m;
	}
	for (int i = 0; i < N; i++) {
		for (int j = 0; j < M; j++) {
			decryptText += a[i][j];
		}
	}
	for (int i = 0; i < N; i++) {
		delete[] a[i];
	}
	delete[] a;
	std::clock_t duration = (std::clock() - time);
	std::cout << "Time of Uzumaki route decryption: " << duration << " ms" << std::endl;
	return decryptText;
}
#pragma endregion

#pragma region Swap
Swaps::Swaps() {
	
}
std::vector<std::tuple<int, int>>Swaps::indexColOrRow(std::string key) {
	std::vector<std::tuple<int, int>>map;
	for (int i = 0; i < this->str.size(); i++) {
		for (int j = 0; j < key.size(); j++) {
			if (this->str[i] == key[j]) {
				map.push_back(std::make_tuple(j, map.size()));
			}
		}
	}
	return map;
}
std::string Swaps::matrixEncrypt(std::string str, const std::string& firstKey, const std::string& secondKey) {
	std::string xd1 = firstKey;
	std::string xd2 = secondKey;
	while (xd1.size() * xd2.size() < str.size()) {
		xd1.append(xd1);
		xd2.append(xd2);
	}
	std::vector<std::tuple<int, int>>map=indexColOrRow(xd1);
	std::vector<std::tuple<int, int>>map1 = indexColOrRow(xd2);
	std::string encrypt;
	char** a = new char* [xd1.size()];
	for (int i = 0; i < xd1.size(); i++) {
		a[i] = new char[xd2.size()];
	}
	char** b = new char* [xd1.size()];
	for (int i = 0; i < xd1.size(); i++) {
		b[i] = new char[xd2.size()];
	}
	char** c = new char* [xd1.size()];
	for (int i = 0; i < xd1.size(); i++) {
		c[i] = new char[xd2.size()];
	}
	int k = 0;
	while (str.size() < xd1.size() * xd2.size()) {
		str += '\0';
	}
	std::clock_t time = std::clock();
	for (int i = 0; i < xd1.size(); i++) {
		for (int j = 0; j < xd2.size(); j++) {
			a[i][j] = str[k];
			k++;
		}
	}
	//swap by rows
	for (int i = 0; i < xd1.size(); i++) {
		for (int j = 0; j < xd2.size(); j++) {
			b[i][j] = a[std::get<0>(map[i])][j];
		}
	}
	//swap by columns
	for (int i = 0; i < xd1.size(); i++) {
		for (int j = 0; j < xd2.size(); j++) {
			c[i][j] = b[i][std::get<0>(map1[j])];
		}
	}
	for (int i = 0; i < xd1.size(); i++) {
		for (int j = 0; j < xd2.size(); j++) {
			encrypt += c[i][j];
		}
	}
	for (int i = 0; i < xd1.size(); i++) {
		delete[] c[i];
	}
	delete[] c;
	for (int i = 0; i < xd1.size(); i++) {
		delete[] b[i];
	}
	delete[] b;
	for (int i = 0; i < xd1.size(); i++) {
		delete[] a[i];
	}
	delete[] a;
	std::clock_t duration = (std::clock() - time);
	std::cout << "Time of Multiple Matrix Swap encryption: " << duration << " ms" << std::endl;
	return encrypt;
	//sorry, i cannot imagine easier solution
}
std::string Swaps::matrixDecrypt(std::string str, const std::string& firstKey, const std::string& secondKey) {
	std::string xd1 = firstKey;
	std::string xd2 = secondKey;
	std::clock_t time = std::clock();
	//fuck, i'm dumb
	while (xd1.size() * xd2.size() < str.size()) {
		xd1.append(xd1);
		xd2.append(xd2);
	}
	while (xd1.size() * xd2.size() > str.size()) {
		str += '\0';
	}

	std::vector<std::tuple<int, int>>map = indexColOrRow(xd1);
	std::vector<std::tuple<int, int>>map1 = indexColOrRow(xd2);
	std::string encrypt;
	char** a = new char* [xd1.size()];
	for (int i = 0; i < xd1.size(); i++) {
		a[i] = new char[xd2.size()];
	}
	char** b = new char* [xd1.size()];
	for (int i = 0; i < xd1.size(); i++) {
		b[i] = new char[xd2.size()];
	}
	char** c = new char* [xd1.size()];
	for (int i = 0; i < xd1.size(); i++) {
		c[i] = new char[xd2.size()];
	}
	int k = 0;
	for (int i = 0; i < xd1.size(); i++) {
		for (int j = 0; j < xd2.size(); j++) {
			a[i][j] = str[k];
			k++;
		}
	}
	//swap by rows
	for (int i = 0; i < xd1.size(); i++) {
		for (int j = 0; j < xd2.size(); j++) {
			b[std::get<0>(map[i])][j] = a[i][j];
		}
	}
	//swap by columns
	for (int i = 0; i < xd1.size(); i++) {
		for (int j = 0; j < xd2.size(); j++) {
			c[i][std::get<0>(map1[j])] = b[i][j];
		}
	}
	for (int i = 0; i < xd1.size(); i++) {
		for (int j = 0; j < xd2.size(); j++) {
			encrypt += c[i][j];
		}
	}
	for (int i = 0; i < xd1.size(); i++) {
		delete[] c[i];
	}
	delete[] c;
	for (int i = 0; i < xd1.size(); i++) {
		delete[] b[i];
	}
	delete[] b;
	for (int i = 0; i < xd1.size(); i++) {
		delete[] a[i];
	}
	delete[] a;
	std::clock_t duration = (std::clock() - time);
	std::cout << "Time of Multiple Matrix Swap decryption: " << duration << " ms" << std::endl;
	return encrypt;
}
#pragma endregion