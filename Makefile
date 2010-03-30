# Makefile for iPhone Application for Xcode gcc compiler (SDK Headers)

PROJECTNAME=iphone
APPFOLDER=$(PROJECTNAME).app
INSTALLFOLDER=$(PROJECTNAME).app

IPHONE_IP=192.168.1.76

CC=arm-apple-darwin9-gcc
LD=$(CC)

LDFLAGS=	-lobjc \
		-bind_at_load \
		-framework Foundation \
		-framework CoreFoundation \
		-framework UIKit \
		-framework CoreGraphics \
		-lsqlite3.0 \
		-w
#LDFLAGS += -framework AddressBookUI
#LDFLAGS += -framework AddressBook
#LDFLAGS += -framework QuartzCore
#LDFLAGS += -framework CoreAudio
#LDFLAGS += -framework AudioToolbox
#LDFLAGS += -framework SystemConfiguration
#LDFLAGS += -framework CFNetwork
#LDFLAGS += -framework MediaPlayer

CFLAGS = -DDEBUG -std=c99
#TODO:how to make it search subdir
CFLAGS += -I./Classes/ObjectiveResource
CFLAGS += -I./Classes/ObjectiveResource/objective_support/Core
CFLAGS += -I./Classes/ObjectiveResource/objective_support/Core/Inflections
CFLAGS += -I./Classes/ObjectiveResource/objective_support/Serialization
CFLAGS += -I./Classes/ObjectiveResource/objective_support/Serialization/XML
CFLAGS += -I./Classes/ObjectiveResource/objective_support/Serialization/JSON
CFLAGS += -I./Classes/ObjectiveResource/objective_support/json-framework
CFLAGS += -I./Classes/SQLPO
CFLAGS += -I./Classes/Models

#一定要引入pre-compiled header，否则每个source要手动引入Foundation/Foundation.h
CFLAGS += -include ./*_Prefix.pch
#以下内容会导致iphone报 No class named iphoneAppDelegate is loaded的错误
#CFLAGS += -x objective-c-header 


BUILDDIR=./build
SRCDIR=./Classes
RESDIR=./Resources
OBJS=$(patsubst %.m,%.o,$(wildcard $(SRCDIR)/*.m))
OBJS+=$(patsubst %.m,%.o,$(wildcard $(SRCDIR)/**/*.m))
OBJS+=$(patsubst %.m,%.o,$(wildcard $(SRCDIR)/**/**/*.m))
OBJS+=$(patsubst %.m,%.o,$(wildcard $(SRCDIR)/**/**/**/*.m))
OBJS+=$(patsubst %.m,%.o,$(wildcard $(SRCDIR)/**/**/**/**/*.m))
OBJS+=$(patsubst %.m,%.o,$(wildcard $(SRCDIR)/**/**/**/**/**/*.m))
OBJS+=$(patsubst %.c,%.o,$(wildcard $(SRCDIR)/**/*.c))
#指定根目录下的main.m，否则会出现编译MakeFile.o
OBJS+=$(patsubst %.m,%.o,$(wildcard *.m))
RESOURCES=$(wildcard $(RESDIR)/*)

all:	$(PROJECTNAME) bundle

$(PROJECTNAME):	$(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^ 

bundle:	$(PROJECTNAME)
	@mkdir -p $(BUILDDIR)/$(APPFOLDER)
	@mv $(PROJECTNAME) $(BUILDDIR)/$(APPFOLDER)/$(PROJECTNAME)_
	@cp -r $(RESOURCES) $(BUILDDIR)/$(APPFOLDER)
	@#破解签名的需要使用sh文件转向至已签名的可执行文件
	@cat toolchain.sh | sed 's/$${PRODUCT_NAME.*}/$(PROJECTNAME)/' > $(BUILDDIR)/$(APPFOLDER)/$(PROJECTNAME)
	@chmod +x $(BUILDDIR)/$(APPFOLDER)/$(PROJECTNAME)
	@#替换Info.plist中的变量
	@cat $(PROJECTNAME)-Info.plist | sed 's/$${PRODUCT_NAME.*}/$(PROJECTNAME)/' | sed 's/$${EXECUTABLE_NAME}/$(PROJECTNAME)/' >  $(BUILDDIR)/$(APPFOLDER)/Info.plist
	@echo "APPL????" > $(BUILDDIR)/$(APPFOLDER)/PkgInfo

main.o:	main.m
	$(CC) -c $< -o $@

%.o:	%.m
	$(CC) -c $(CFLAGS) $< -o $@

deploy: all
	@ssh root@$(IPHONE_IP) "cd /Applications/$(INSTALLFOLDER) && rm -R * || echo 'not found' "
	@scp -r $(BUILDDIR)/$(APPFOLDER) root@$(IPHONE_IP):/Applications
	@ssh root@$(IPHONE_IP) "cd /Applications/$(INSTALLFOLDER) ; ldid -S $(PROJECTNAME)_;"

#不用每次deploy都kill spring，修改的代码会生效
spring:
	@ssh root@$(IPHONE_IP) "killall SpringBoard"

uninstall:
	@ssh root@$(IPHONE_IP) 'rm -fr /Applications/$(INSTALLFOLDER); killall SpringBoard'
	@echo "Application $(INSTALLFOLDER) uninstalled"

clean:
	@rm -f $(SRCDIR)/*.o $(SRCDIR)/**/*.o *.o
	@rm -rf $(BUILDDIR)
	@rm -f $(PROJECTNAME)
