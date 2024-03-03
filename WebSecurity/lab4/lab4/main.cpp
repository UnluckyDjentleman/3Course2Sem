#include "SchiferAlg.h"

int main() {
	setlocale(LC_ALL, "Russian");
	std::string alphabet = "��������������������������������";
	std::string str = ReadTextFromFile("original.txt");
	std::cout << "=========================original.txt=========================" << std::endl;
	OutputAppearances(SymbolDictionary(str, alphabet), str);
	std::cout << std::endl;
	std::string caesar = CaesarSchifer(str, 7, 10, alphabet);
	std::cout << std::endl;
	WriteOnFile("encrypt�aesar.txt", caesar);
	std::cout << "=========================encryptCaesar.txt=========================" << std::endl;
	OutputAppearances(SymbolDictionary(ReadTextFromFile("encrypt�aesar.txt"), alphabet), ReadTextFromFile("encrypt�aesar.txt"));
	std::cout << std::endl;
	std::string vigener = Vigenere(str, alphabet, "��������");
	std::cout << std::endl;
	WriteOnFile("encryptVigenere.txt", vigener);
	std::cout << "=========================encryptVigenere.txt=========================" << std::endl;
	OutputAppearances(SymbolDictionary(ReadTextFromFile("encryptVigenere.txt"), alphabet), ReadTextFromFile("encryptVigenere.txt"));
	

	std::string str1 = ReadTextFromFile("encrypt�aesar.txt");
	std::string str2 = ReadTextFromFile("encryptVigenere.txt");
	WriteOnFile("decryptCaesar.txt", CaesarDeschifer(str1, 7, 10, alphabet));
	WriteOnFile("decryptVigenere.txt", VigenereDeschifer(str2, alphabet, "��������"));
}