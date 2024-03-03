#pragma once
#include <iostream>
#include<fstream>
#include<string>
#include <map>
#include<algorithm>
#include <vector>
#include<cmath>
#include<time.h>

std::map<char, int>SymbolDictionary(std::string text, std::string a);
void OutputAppearances(std::map<char, int>xd, std::string text);
std::string ReadTextFromFile(std::string fileName);
void WriteOnFile(std::string fileName, std::string encryptText);
std::string CaesarSchifer(std::string text, int a, int b, std::string alph);
std::string Vigenere(std::string text, std::string alphabet, std::string baseString);
std::string CaesarDeschifer(std::string text, int a, int b, std::string alph);
std::string VigenereDeschifer(std::string text, std::string alphabet, std::string baseString);
int EuclidReference(int a, int N);