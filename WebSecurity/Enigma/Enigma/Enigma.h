#pragma once
#include <iostream>
#include<fstream>
#include<string>
#include <map>
#include<algorithm>
#include <vector>
#include<cmath>
#include<time.h>

class Enigma {
private:
	int rightRotor;
	int middleRotor;
	int leftRotor;

	int rightAfter = 0;
	int middleAfter = 0;
	int leftAfter = 0;

	int rightFullRotates = 0;
	int middleFullRotates = 0;
	int leftFullRotates = 0;

	int rightStep = 2;
	int middleStep = 2;
	int leftStep = 1;

	std::map<char, char>reflector{
		{'a','f'},
		{'b','v'},
		{'c','p'},
		{'d','j'},
		{'e','i'},
		{'g','o'},
		{'k','r'},
		{'l','z'},
		{'m','x'},
		{'n','w'},
		{'t','q'},
		{'s','u'}
	};
	std::string alphabet = "abcdefghijklmnopqrstuvwxyz";
	std::string rotorOne = "ajdksiruxblhwtmcqgznpyfvoe";
	std::string rotorTwo = "bdfhjlcprtxvznyeiwgakmusqo";
	std::string rotorThree = "vzbrgityupsdnhlxawmjqofeck";
public:
	Enigma(int rightRotor, int middleRotor, int leftRotor);
	std::string Encrypt(std::string enc);
	std::string Decrypt(std::string decr);
	char EncryptWithRotor(char letter, std::string alphabet, std::string alphabetEncrypt, int offset);
	char EncryptWithReflector(char letter);
	char DecryptWithRotor(char letter, std::string alphabet, std::string alphabetEncrypt, int offset);
};

class EnigmaMenu {
public:
	std::map<char,int> GetSymbolsAppearance(std::string txt);
	std::string ReadFromFile(std::string fileName);
	void WriteOnFile(std::string fileName, std::string text);
};