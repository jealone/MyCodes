/*************************************************************************
	> File Name: cards_switch.c
	> Author: Arthur Guo
	> Mail: jealone@gmail.com 
	> Created Time: 2014年05月11日 星期日 15时22分40秒
 ************************************************************************/

#include <stdio.h>

int main()
{
	char card_name[3];
	puts("输入牌名：");
	scanf("%2s", card_name);
	int val = 0;
	switch(card_name[0]) {
		case 'K' :
		case 'Q' :
		case 'J' :
			val = 10;
			break;
		case 'A' :
			val = 11;
			break;
		default :
			val = atoi(card_name);
	}
	printf("%d",val);
	if ((val > 2) && (val < 7))
		puts("计数增加");
	else if (10 == val)
		puts("计数减少");
	return 0;
}
