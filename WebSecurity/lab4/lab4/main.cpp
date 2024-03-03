#include "SchiferAlg.h"

int main() {
	setlocale(LC_ALL, "Russian");
	std::string alphabet = "��������������������������������";
	std::string str = ReadTextFromFile("original.txt");
	std::cout << "=========================original.txt=========================" << std::endl;
	OutputAppearances(SymbolDictionary(str, alphabet), str);
	WriteOnFile("encrypt�aesar.txt", CaesarSchifer(str, 7, 10, alphabet));
	std::cout << "=========================encryptCaesar.txt=========================" << std::endl;
	OutputAppearances(SymbolDictionary(ReadTextFromFile("encrypt�aesar.txt"), alphabet), ReadTextFromFile("encrypt�aesar.txt"));
	WriteOnFile("encryptVigenere.txt", Vigenere(str, alphabet, "��������"));
	std::cout << "=========================encryptVigenere.txt=========================" << std::endl;
	OutputAppearances(SymbolDictionary(ReadTextFromFile("encryptVigenere.txt"), alphabet), ReadTextFromFile("encryptVigenere.txt"));
	

	std::string str1 = ReadTextFromFile("encrypt�aesar.txt");
	std::string str2 = ReadTextFromFile("encryptVigenere.txt");
	WriteOnFile("decryptCaesar.txt", CaesarDeschifer(str1, 7, 10, alphabet));
	WriteOnFile("decryptVigenere.txt", VigenereDeschifer(str2, alphabet, "��������"));
}