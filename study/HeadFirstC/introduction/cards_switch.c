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
	int count = 0;
	//检测输入字符
	while('X' != card_name[0]) {	
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
			case 'X' :
				continue;
			default :
				val = atoi(card_name);
				if ((val < 1) || (val > 10))
				{
					puts("输入错误牌");
					continue;
				}
		}

		if ((val > 2) && (val < 7)) {
			count++;
			puts("计数增加");
		} else if (10 == val) {
			count--;
			puts("计数减少");
		}

		printf("当前计数：%d\n", count);
	}
	return 0;
}
