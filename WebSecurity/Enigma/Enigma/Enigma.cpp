#include "Enigma.h"

#pragma region EnigmaMenu
std::map<char,int> EnigmaMenu::GetSymbolsAppearance(std::string txt) {
	std::map<char, int>symbolsDictionary;
	for (int i = 0; i < txt.size(); i++) {
		if (!symbolsDictionary.count(txt[i])) {
			symbolsDictionary.insert(std::make_pair(txt[i], 1));
		}
		else {
			symbolsDictionary[txt[i]] += 1;
		}
	}
	std::cout << "     Symbol     " << "|" << "     Appearance     " << std::endl;
	std::cout << "=====================================" << std::endl;
	for (auto elem = symbolsDictionary.begin(); elem != symbolsDictionary.end(); elem++) {
		std::cout << elem->first << "               " << "|" << (double)elem->second / txt.size() << "    " << std::endl;
	}
	return symbolsDictionary;
}

std::string EnigmaMenu::ReadFromFile(std::string fileName) {
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

void EnigmaMenu::WriteOnFile(std::string fileName, std::string text) {
	std::ofstream onf("../Texts/" + fileName);
	if (!onf.is_open()) {
		std::cerr << "Cannot read data from file!";
		exit(-1);
	}
	onf << text << std::endl;
	return;
}
#pragma endregion 

#pragma region Enigma
Enigma::Enigma(int rightRotor, int middleRotor, int leftRotor) {
	this->rightRotor = rightRotor;
	this->middleRotor = middleRotor;
	this->leftRotor = leftRotor;
}

char Enigma::EncryptWithRotor(char letter, std::string alphabet, std::string alphabetEncrypt, int offset) {
	return alphabetEncrypt[(alphabet.find(letter)+offset)%alphabet.size()];
}

char Enigma::DecryptWithRotor(char letter, std::string alphabet, std::string alphabetEncrypt, int offset) {
	return alphabetEncrypt[(alphabet.find(letter) + alphabet.size() - offset) % alphabet.size()];
}

char Enigma::EncryptWithReflector(char letter) {
	auto it = std::find_if(this->reflector.begin(), this->reflector.end(), [&letter](const std::map<char, char>::value_type& ch) {
			return ch.second == letter;
		});
	if (this->reflector.count(letter)) {
		return this->reflector[letter];
	}
	else if (it!= this->reflector.end()) {
		return it->first;
	}
	else {
		return letter;
	}
}

std::string Enigma::Encrypt(std::string enc) {
	int rightOffsets = this->rightRotor;
	int middleOffsets = this->middleRotor;
	int leftOffsets = this->leftRotor;
	std::string encryptedText;
	//realization is illustrated in EnigmaAlgorythm.png
	for (auto c = enc.begin(); c != enc.end(); c++) {
		if (alphabet.find(*c)!=-1) {
			char letterAfterRight = EncryptWithRotor(*c, alphabet, rotorThree, this->rightRotor);
			char letterAfterMiddle = EncryptWithRotor(letterAfterRight, alphabet, rotorTwo, this->middleRotor);
			char letterAfterLeft = EncryptWithRotor(letterAfterMiddle, alphabet, rotorOne, this->leftRotor);
			char letterReflector = EncryptWithReflector(letterAfterLeft);
			char letterAfterReflectorLeft = EncryptWithRotor(letterReflector, rotorOne, alphabet, this->leftRotor);
			char letterAfterReflectorMiddle = EncryptWithRotor(letterAfterReflectorLeft, rotorTwo, alphabet, this->middleRotor);
			char letterAfterReflectorRight = EncryptWithRotor(letterAfterReflectorMiddle, rotorThree, alphabet, this->rightRotor);
			//then goes offset of rotors
			rightOffsets += rightStep;
			this->rightRotor = rightOffsets % alphabet.size();

			if (rightOffsets / alphabet.size() > 0) {
				this->rightFullRotates = rightOffsets / alphabet.size();
				middleOffsets = this->rightFullRotates * this->middleStep;
				this->middleRotor = middleOffsets % alphabet.size();
			}
			if (middleOffsets / alphabet.size() > 0) {
				this->middleFullRotates = middleOffsets / alphabet.size();
				middleOffsets = this->middleFullRotates * this->leftStep;
				this->leftRotor = leftOffsets % alphabet.size();
			}
			if (leftOffsets / alphabet.size() > 0) {
				this->leftFullRotates = rightOffsets / alphabet.size();
			}
			encryptedText += letterAfterReflectorRight;
		}
		else {
			encryptedText += *c;
		}
	}
	return encryptedText;
}

std::string Enigma::Decrypt(std::string decr) {
	int rightOffsets = this->rightRotor;
	int middleOffsets = this->middleRotor;
	int leftOffsets = this->leftRotor;
	std::string decryptedText;
	//realization is illustrated in EnigmaAlgorythm.png, but reversed
	for (auto c = decr.begin(); c != decr.end(); c++) {
		if (alphabet.find(*c)!=-1) {
			char letterAfterRight = DecryptWithRotor(*c, alphabet, rotorThree, this->rightRotor);
			char letterAfterMiddle = DecryptWithRotor(letterAfterRight, alphabet, rotorTwo, this->middleRotor);
			char letterAfterLeft = DecryptWithRotor(letterAfterMiddle, alphabet, rotorOne, this->leftRotor);
			char letterReflector = EncryptWithReflector(letterAfterLeft);
			char letterAfterReflectorLeft = DecryptWithRotor(letterReflector, rotorOne, alphabet, this->leftRotor);
			char letterAfterReflectorMiddle = DecryptWithRotor(letterAfterReflectorLeft, rotorTwo, alphabet, this->middleRotor);
			char letterAfterReflectorRight = DecryptWithRotor(letterAfterReflectorMiddle, rotorThree, alphabet, this->rightRotor);
			//then goes offset of rotors
			rightOffsets += rightStep;
			this->rightRotor = rightOffsets % alphabet.size();

			if (rightOffsets / alphabet.size() > 0) {
				this->rightFullRotates = rightOffsets / alphabet.size();
				middleOffsets = this->rightFullRotates * this->middleStep;
				this->middleRotor = middleOffsets % alphabet.size();
			}
			if (middleOffsets / alphabet.size() > 0) {
				this->middleFullRotates = middleOffsets / alphabet.size();
				middleOffsets = this->middleFullRotates * this->leftStep;
				this->leftRotor = leftOffsets % alphabet.size();
			}
			if (leftOffsets / alphabet.size() > 0) {
				this->leftFullRotates = rightOffsets / alphabet.size();
			}
			decryptedText += letterAfterReflectorRight;
		}
		else {
			decryptedText += *c;
		}
	}
	return decryptedText;
}
#pragma endregion