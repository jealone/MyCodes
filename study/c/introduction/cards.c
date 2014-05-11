/*************************************************************************
	> File Name: cards.c
	> Author: Arthur Guo
	> Mail: jealone@gmail.com 
	> Created Time: 2014年05月11日 星期日 13时23分17秒
 ************************************************************************/

#include <stdio.h>
#include <stdlib.h>

int main()
{
	char card_name[3];
	puts("输入牌名：");
	scanf("%2s", card_name);
	int val = 0;
	if ('K' == card_name[0]) {
		val = 10;
	} else if ( 'Q' == card_name[0]) {
		val = 10;
	} else if ( 'J' == card_name[0]) {
		val = 10;
	} else if ( 'A' == card_name[0]) {
		val = 11;
	} else {
		val = atoi(card_name);
	}
	if ((val > 2) && (val < 7))
		puts("计数增加");
	else if (10 == val)
		puts("计数减少");
	return 0;
}
