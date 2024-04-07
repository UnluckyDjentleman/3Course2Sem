#include"Header.h"
#pragma region Menu
std::string Menu::ReadFromFile(std::string fileName) {
	std::fstream inf("../Texts/" + fileName);
	std::string readTo;

	if (!inf) {
		std::cerr << "Cannot read data from file!";
		exit(-1);
	}
	while (std::getline(inf, readTo)) {
		inf >> readTo;
	}
	return readTo;
}
void Menu::WriteOnFile(std::string fileName, std::string text) {
	std::ofstream onf("../Texts/" + fileName);
	if (!onf.is_open()) {
		std::cerr << "Cannot read data from file!";
		exit(-1);
	}
	onf << text << std::endl;
	return;
}
#pragma endregion

#pragma region DES
bitset<64> DES::char_to_bit(string s) {
	bitset<64> bits;
	int x = 0;
	for (int i = 0; i < 8; i++)
	{
		int num = int(s[i]);
		bitset<8> temp(num);
		for (int j = 7; j >=0 ; j--)
		{
			bits[x + j] = temp[7-j];
		}
		x += 8;
	}
	return bits;
}
bitset<64>DES::cycleEncrypt(bitset<64>plain) {
	bitset<32>left;
	bitset<32>right;
	bitset<32>newLeft;
	bitset<64>currentBits;
	bitset<64>cypher;
	for (int i = 0; i < 64; i++)
		currentBits[i] = plain[IP[i] - 1];
	for (int i = 0; i < 32; i++) {
		left[i] = currentBits[i];
		right[i] = currentBits[32 + i];
	}
	for (int it = 0; it < 16; it++) {
		newLeft = right;
		right = left ^ F(right,subkeys[it]);
		left = newLeft;
	}
	for (int i = 0; i < 32; i++) {
		cypher[i] = right[i];
	}
	for (int i = 32; i < 64; i++) {
		cypher[i] = left[i - 32];
	}
	currentBits = cypher;
	cypher = finalSwap(currentBits);
	return cypher;
}
bitset<64>DES::cycleDecrypt(bitset<64>plain) {
	bitset<32>left;
	bitset<32>right;
	bitset<32>newLeft;
	bitset<64>currentBits;
	bitset<64>cypher;
	for (int i = 0; i < 64; i++)
		currentBits[i] = plain[IP[i] - 1];
	for (int i = 0; i < 32; i++) {
		left[i] = currentBits[i];
		right[i] = currentBits[32 + i];
	}
	for (int it = 0; it < 16; it++) {
		newLeft = right;
		right = left ^ F(right, subkeys[15-it]);
		left = newLeft;
	}
	for (int i = 0; i < 32; i++) {
		cypher[i] = right[i];
	}
	for (int i = 32; i < 64; i++) {
		cypher[i] = left[i - 32];
	}
	currentBits = cypher;
	cypher = finalSwap(currentBits);
	return cypher;
}
bitset<56>DES::keyAfterShift(bitset<56>key, int shift) {
	bitset<28>k1;
	bitset<28>k2;
	for (int i = 0; i < 28; i++) {
		k1[i] = key[i];
	}
	for (int j = 28; j < 56; j++) {
		k2[j-28] = key[j];
	}
	if (shift == 1)
	{
		for (int i = 0; i < 27; i++)
		{
			if (i - shift < 0) {
				key[i - shift + 28] = k1[i];
				key[i - shift + 56] = k2[i];
			}
			else {
				key[i] = k1[i + shift];
				key[i + 28] = k2[i + shift];
			}
		}
	}
	if (shift == 2)
	{
		for (int i = 0; i < 26; i++)
		{
			if (i - shift < 0) {
				key[i - shift + 28] = k1[i];
				key[i - shift + 56] = k2[i];
			}
			else {
				key[i] = k1[i + shift];
				key[i + 28] = k2[i + shift];
			}
		}
	}
	return key;
}
void DES::keyRemaker(bitset<64>key,int i) {
	bitset<56>keyRemade;
	for (int i = 0; i < 56; i++) {
		keyRemade[i] = key[PC_1[i] - 1];
	}
	keyRemade = keyAfterShift(keyRemade, i);
	bitset<48>keykey;
	for (int i = 0; i < 48; i++) {
		keykey[i] = keyRemade[PC_2[i] - 1];
	}
	subkeys[i] = keykey;
}
bitset<32>DES::F(bitset<32>part, bitset<48>xd) {
	bitset<48>expandPart;
	for (int i = 0; i < 48; i++) {
		expandPart[47-i] = part[32-E[i]];
	}
	//XOR
	expandPart = expandPart ^ xd;
	//S-boxes
	bitset<32>output;
	int x = 0;
	for (int i = 0; i < 48; i = i + 6)
	{
		int row = expandPart[i] * 2 + expandPart[i + 5];
		int col = expandPart[i + 1] * 8 + expandPart[i + 2] * 4 + expandPart[i + 3] * 2 + expandPart[i + 4];
		int num = S_BOX[i / 6][row][col];
		bitset<4> temp(num);
		output[x + 3] = temp[0];
		output[x + 2] = temp[1];
		output[x + 1] = temp[2];
		output[x] = temp[3];
		x += 4;
	}
	//P-boxes
	bitset<32>tmp = output;
	for (int i = 0; i < 32; i++) {
		output[i] = tmp[P[i] - 1];
	}
	return output;
}
bitset<64>DES::finalSwap(std::bitset<64>finalSwap) {
	bitset<64>temp;
	for (int i = 0; i < 64; i++) {
		temp[i] = finalSwap[IP1[i]-1];
	}
	return temp;
}

bitset<64> DES::change(bitset<64> temp) {
	bitset<64> bits;
	bitset<8> n;
	for (int i = 0; i < 64; i = i + 8)
	{
		for (int j = 0; j < 8; j++)
		{
			bits[i + j] = temp[i + 7 - j];
		}
	}
	return bits;
}

std::string DES::EncryptDES(string cypherText, string key) {
	bitset<64>none;
	string str;
	for (int i = 0; i < cypherText.size(); i=i+8) {
		int e=0;
		string subs;
		bitset<64> toRemake = char_to_bit(cypherText.substr(i, 8));
		for (int i = 0; i < 16; i++) {
			keyRemaker(char_to_bit(key), i);
		}
		none=cycleEncrypt(toRemake);
		str += none.to_string();
	}
	return str;
}
std::string DES::DecryptDES(string cypherText, string key) {
	bitset<64>none;
	bitset<64>lol;
	bitset<64>bb;
	string str;
	for (int i = 0; i < cypherText.size(); i = i + 64) {
		int e = 0;
		string subs;
		string xd = cypherText.substr(i, 64);
		bb = bitset<64>(xd);
		for (int i = 0; i < 16; i++) {
			keyRemaker(char_to_bit(key), i);
		}
		none = cycleDecrypt(bb);
		for (int j = 0; j < 8; j++) {
			for (int i = 0; i < 8; i++) {
				bitset<8>c(none[(j*8)+i]);
				e += c.to_ulong() * pow(2, 7 - i);
			}
			subs += char(e);
			e = 0;
		}
		str += subs;
	}
	return str;
}
int DES::getAvalanche(string openText, string encryptedText) {
	int xd = 0;
	for (int i = 0; i < encryptedText.size(); i++) {
		int x1 = openText[i] - 48;
		int x2 = encryptedText[i] - 48;
		int xorus = x1 ^ x2;
		while (xorus != 0)
		{
			if ((xorus & 1) == 1)
				xd++;
			xorus >>= 1;
		}
	}
	return xd;
}
#pragma endregion