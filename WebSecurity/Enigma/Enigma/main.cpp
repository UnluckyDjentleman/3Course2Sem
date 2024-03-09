#include"Enigma.h"

int main() {
	EnigmaMenu em;
	Enigma enigmaEncryption=Enigma(0,0,0);
	Enigma enigmaDecryption = Enigma(0, 0, 0);
	std::string textFromFile= em.ReadFromFile("original.txt");
	em.GetSymbolsAppearance(textFromFile);
	std::string encryptedText = enigmaEncryption.Encrypt(textFromFile);
	em.WriteOnFile("encrypted_text.txt", encryptedText);
	std::string textFromNewFile = em.ReadFromFile("encrypted_text.txt");
	em.GetSymbolsAppearance(textFromNewFile);
	std::string decryptedText = enigmaDecryption.Decrypt(textFromNewFile);
	em.WriteOnFile("decrypted_text.txt", decryptedText);
	system("pause");
	return 0;
}