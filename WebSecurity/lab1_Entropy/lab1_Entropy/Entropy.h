#pragma once
#include <iostream>
#include<fstream>
#include<string>
#include <map>
#include<algorithm>
#include <vector>
#include<cmath>

std::map<char, int> CountSymbolsInText(std::string str);
double ShannonEntropy(std::string str);
double EffectiveEntropy(std::string str, double p);
std::string InfoFromFile(std::string fileName);
double InfoAmount(std::string alphabet, std::string str, double p);
double InfoAmount(std::string alphabet, std::string str);
bool IsBinaryAlphabet(std::string alphabet);
