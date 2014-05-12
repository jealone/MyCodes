/*************************************************************************
	> File Name: champagne.c
	> Author: Arthur Guo
	> Mail: jealone@gmail.com 
	> Created Time: 2014年05月12日 星期一 11时36分49秒
 ************************************************************************/

#include <stdio.h>
#include <stdlib.h>

int main(){
	int stock = 180;
	while(stock > 0) {
		printf("Current %i glasses left\n", stock);
		int champagneOrderd = 0;
		puts("Please type the champagne order number:");
		scanf("%d", &champagneOrderd);
		printf("You ordered %i glasses\n", champagneOrderd);
		if(stock < champagneOrderd) {
			printf("We don't have enough champagne, Only %i remains!\n", stock);
			continue;
		}
		stock = stock - champagneOrderd;
	}
	puts("We’re out of stock, baby!");
	return 0;
}
