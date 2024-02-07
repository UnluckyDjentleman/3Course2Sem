#include "Entropy.h"

using namespace std;

int main() {
	setlocale(LC_ALL, "Russian");
	string rus = InfoFromFile("russian.txt");
	string eng = InfoFromFile("english.txt");
	string bin = InfoFromFile("binary.txt");
	string me = InfoFromFile("me.txt");
	string meAscii = InfoFromFile("meASCII.txt");

	cout << "===========================================";
	cout << "\nEntropy of Russian Language: " << ShannonEntropy(rus);
	cout << "\nEntropy of English Language: " << ShannonEntropy(eng);
	cout << "\nEntropy of Binary Language: " << ShannonEntropy(bin);
	cout << "\n===================P=0=====================";
	cout << "\nInformational Amount of Russian Language: " << InfoAmount(rus,me);
	cout << "\nInformational Amount of English Language: " << InfoAmount(eng,meAscii);
	cout << "\nInformational Amount of Binary Language: " << InfoAmount(meAscii,meAscii);
	cout << "\n===================P=0.1===================";
	cout << "\nInformational Amount of Russian Language: " << InfoAmount(rus, me,0.1);
	cout << "\nInformational Amount of English Language: " << InfoAmount(eng, meAscii, 0.1);
	cout << "\nInformational Amount of Binary Language: " << InfoAmount(meAscii, meAscii, 0.1);
	cout << "\n===================P=0.5===================";
	cout << "\nInformational Amount of Russian Language: " << InfoAmount(rus, me, 0.5);
	cout << "\nInformational Amount of English Language: " << InfoAmount(eng, meAscii, 0.5);
	cout << "\nInformational Amount of Binary Language: " << InfoAmount(meAscii, meAscii, 0.5);
	cout << "\n===================P=1.0===================";
	cout << "\nInformational Amount of Russian Language: " << InfoAmount(rus, me, 1);
	cout << "\nInformational Amount of English Language: " << InfoAmount(eng, meAscii, 1);
	cout << "\nInformational Amount of Binary Language: " << InfoAmount(meAscii, meAscii, 1);

}