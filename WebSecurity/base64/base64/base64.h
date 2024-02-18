#pragma once
#include<string>
#include<cstdlib>
#include<map>
#include<vector>
#include<iostream>
#include<fstream>
#include<algorithm>
#include <vector>
#include<bitset>
#include<cmath>

using namespace std;
std::map<char, int> CountSymbolsInText(std::string str);
string ReadTextFromFile(string fileName);
double ShannonEntropy(string str);
double HartleyEntropy(string str);
double GetRedunancy(double x, double y);
int CodeAt(char c);
string TextToBase64(string str);
string Xor(string a, string b);