#!/bin/bash
#所有在模板test和check所确定的范围内的行都被打印 
sed -n '/context1/,/context2/p' filename
