#include "Header.h"



int main() {
	Menu menu = Menu::Menu();
	RouteSwap routeSwapper=RouteSwap::RouteSwap();
	menu.WriteOnFile("encrypted_shit.txt", routeSwapper.matrixRouteEncrypt(32, 32, menu.ReadFromFile("text.txt")));
	menu.WriteOnFile("decrypted_shit.txt", routeSwapper.matrixRouteDecrypt(32, 32, menu.ReadFromFile("encrypted_shit.txt")));

	Swaps swap = Swaps::Swaps();
	menu.WriteOnFile("ennnnnnnncryption.txt", swap.matrixEncrypt(menu.ReadFromFile("text.txt")));
	menu.WriteOnFile("decryption.txt", swap.matrixDecrypt(menu.ReadFromFile("ennnnnnnncryption.txt")));
}