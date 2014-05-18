/*************************************************************************
	> File Name: southeast.c
	> Author: Arthur Guo
	> Mail: jealone@gmail.com 
	> Created Time: 2014年05月18日 星期日 18时08分15秒
 ************************************************************************/

#include <stdio.h>

void go_south_east(int* lat, int* lon)
{
	*lat = *lat-1;
	*lon = *lon+1;
}

int main()
{
	int latitude = 32;
	int longtitude = -64;
	go_south_east(&latitude, &longtitude);
	printf("停！当前位置：[%i, %i]\n",latitude,longtitude);
	return 0;
}
