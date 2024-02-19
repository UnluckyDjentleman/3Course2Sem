#include"base64.h"

int main() {
	string myText = ReadTextFromFile("lorem.txt");
	cout << myText<<endl;
	cout << "======================================================\n";
	cout << "Shannon Entropy: "<< ShannonEntropy(myText)<<endl;
	cout << "Hartley Entropy: "<< HartleyEntropy(myText) << endl;
	cout << "Redunancy: " << GetRedunancy(HartleyEntropy(myText),ShannonEntropy(myText)) << endl;
	cout << "======================================================\n";
	cout << "Base64: " << TextToBase64(myText)<<endl;
	cout << "===========================XOR===========================" << endl;
	string s = Xor("Vladislav", "Goroshchenja");
	cout << s << endl;
	string aa = TextToBase64("Vladislav");
	string bb = TextToBase64("Goroshchenja");
	cout << "XOR to base64: " << TextToBase64(s)<<endl;
	cout << "XOR to base64 xd:" << TextToBase64(Xor(aa, bb));
}