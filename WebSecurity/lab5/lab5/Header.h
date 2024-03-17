#pragma once
#include<iostream>
#include<map>
#include<unordered_map>
#include<string>
#include<fstream>
#include<algorithm>
#include<vector>
#include<tuple>
#include<time.h>

class RouteSwap {
private:
	int N;
	int M;
	std::string str = "abcdefghijklmnopqrstuvwxyz";
public:
	RouteSwap();
	std::string matrixRouteEncrypt(int N, int M, std::string str);
	std::string matrixRouteDecrypt(int N, int M, std::string str);
};

class Swaps {
private:
	std::string firstKey;
	std::string secondKey;
	std::string str = "abcdefghijklmnopqrstuvwxyz";
public:
	Swaps();
	std::vector<std::tuple<int,int>>indexColOrRow(std::string key);
	std::string matrixEncrypt(std::string str, const std::string& firstKey = "uladzislau", const std::string& secondKey = "harashchenja");
	std::string matrixDecrypt(std::string str, const std::string& firstKey = "uladzislau", const std::string& secondKey = "harashchenja");
};

class Menu {
public:
	Menu() {

	};
	std::string ReadFromFile(std::string fileName);
	void WriteOnFile(std::string fileName, std::string text);
	std::map<char, int>SymbolAppearances(std::string txt);
};