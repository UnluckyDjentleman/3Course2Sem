#include "SchiferAlg.h"

int main() {
	setlocale(LC_ALL, "Russian");
	std::string alphabet = "àáâãäå¸æçèéêëìíîïğñòóôõö÷øùúûüışÿ";
	std::string str = ReadTextFromFile("original.txt");
	std::cout << "=========================original.txt=========================" << std::endl;
	OutputAppearances(SymbolDictionary(str, alphabet), str);
	std::cout << std::endl;
	std::string caesar = CaesarSchifer(str, 7, 10, alphabet);
	std::cout << std::endl;
	WriteOnFile("encryptÑaesar.txt", caesar);
	std::cout << "=========================encryptCaesar.txt=========================" << std::endl;
	OutputAppearances(SymbolDictionary(ReadTextFromFile("encryptÑaesar.txt"), alphabet), ReadTextFromFile("encryptÑaesar.txt"));
	std::cout << std::endl;
	std::string vigener = Vigenere(str, alphabet, "ãîğîùåíÿ");
	std::cout << std::endl;
	WriteOnFile("encryptVigenere.txt", vigener);
	std::cout << "=========================encryptVigenere.txt=========================" << std::endl;
	OutputAppearances(SymbolDictionary(ReadTextFromFile("encryptVigenere.txt"), alphabet), ReadTextFromFile("encryptVigenere.txt"));
	

	std::string str1 = ReadTextFromFile("encryptÑaesar.txt");
	std::string str2 = ReadTextFromFile("encryptVigenere.txt");
	WriteOnFile("decryptCaesar.txt", CaesarDeschifer(str1, 7, 10, alphabet));
	WriteOnFile("decryptVigenere.txt", VigenereDeschifer(str2, alphabet, "ãîğîùåíÿ"));
}