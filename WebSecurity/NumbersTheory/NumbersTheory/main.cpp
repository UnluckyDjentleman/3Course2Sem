#include"NumbersTheory.h"

int main() {
	int a = 521;
	int b = 553;
	std::cout <<"GCD("<<a<<","<<b<<"): "<<GCD(a, b)<<std::endl;
	std::cout << "=====================================================" << std::endl;
	std::cout << "Prime numbers from 2 to "+to_string(b)+": " << Print(GetPrimes(b))<<std::endl;
	std::cout << "Prime numbers from "+to_string(a)+" to "+to_string(b)+": " << Print(GetPrimes(b, a)) << std::endl;
	std::cout << "Approximative Count Of Primes: " << GetApproximativeCountOfPrimes(b)<<std::endl;
	std::cout << "=====================================================" << std::endl;
	std::cout << "Concatenated Number: " << GetConcatenatedNumber(a, b) << std::endl;
	std::cout << "Is Concatenated Prime: " << IsPrime(GetConcatenatedNumber(a, b)) << std::endl;
	std::cout << to_string(GetConcatenatedNumber(a, b)) + " in canonical form: " << PrintCanonicalForm(CanonicalForm(GetConcatenatedNumber(a, b))) << std::endl << std::endl;
	std::cout << "=====================================================" << std::endl;
	std::cout << "Concatenated Number: " << GetConcatenatedNumber(b, a) << std::endl;
	std::cout << "Is Concatenated Prime: " << IsPrime(GetConcatenatedNumber(b, a)) << std::endl;
	std::cout << to_string(GetConcatenatedNumber(b, a)) + " in canonical form: " << PrintCanonicalForm(CanonicalForm(GetConcatenatedNumber(b, a))) << std::endl << std::endl;
}