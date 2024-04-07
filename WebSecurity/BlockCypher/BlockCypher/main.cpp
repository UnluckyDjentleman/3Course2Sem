#include"Header.h"
string makeAStringFromBitString(string xd) {
	string fff;
	int e=0;
	for (int j = 0; j < xd.size(); j+=8) {
		for (int i = 0; i < 8; i++) {
			int x = xd[j+i]-'0';
			e += x * pow(2, 7 - i);
		}
		fff += char(e);
		e = 0;
	} 
	return fff;
}
string makeABitStringFromString(string xd) {
	string fff;
	int e = 0;
	for (int j = 0; j < xd.size(); j++) {
		bitset<8>t(xd[j]);
		fff += t.to_string();
	}
	return fff;
}
int main() {
	Menu menu = Menu();
	DES des = DES();
	//ennnnnnnnnnncryption
	string textRead = menu.ReadFromFile("text.txt");
	clock_t start = clock();
	string encryptedText = des.EncryptDES(makeAStringFromBitString(des.EncryptDES(makeAStringFromBitString(des.EncryptDES(textRead,"informat")), "security")), "laborato");
	clock_t end = clock() - start;
	cout << "Encryption time: " << end << " ms"<<endl;
	menu.WriteOnFile("textEncrypted.txt", makeAStringFromBitString(encryptedText));
	cout<<"Colorado Avalanche Effect: "<<des.getAvalanche(makeABitStringFromString(textRead), encryptedText)<<endl;
	//decryption
	//string encryptedTextRead = menu.ReadFromFile("textEncrypted.txt");
	clock_t start1 = clock();
	string decryptedText = des.DecryptDES(makeABitStringFromString(des.DecryptDES(makeABitStringFromString(des.DecryptDES(encryptedText, "laborato")), "security")), "informat");
	clock_t end1 = clock() - start;
	cout << "Decryption time: " << end1 << " ms" << endl; 
	menu.WriteOnFile("textDecrypted.txt", decryptedText);
	//menu.WriteOnFile("textDecrypted.txt", strDecrypted3);
}