#!/bin/bash

#此文件用于替换编译后的可执行文件，转向至已经通过ldid签名的文件(带_后缀)
HT=$(dirname "$0")
exec "${HT}"/${PRODUCT_NAME}_
