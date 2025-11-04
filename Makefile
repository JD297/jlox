.POSIX:

JAVAC         = javac
CFLAGS        = -Werror -d $(BUILDDIR)

TARGET        = Lox.jar
PREFIX        = /usr/local
SRCDIR        = src
BUILDDIR      = build

PACKAGE       = com/craftinginterpreters/lox

CLASSES       = $(PACKAGE)/Lox.class

$(BUILDDIR)/$(TARGET): $(BUILDDIR)/$(CLASSES)
	jar cfe $@ $(PACKAGE)/Lox -C $(BUILDDIR) $(CLASSES)

$(BUILDDIR)/$(PACKAGE)/Lox.class: $(SRCDIR)/$(PACKAGE)/Lox.java
	$(JAVAC) $(CFLAGS) $(SRCDIR)/$(PACKAGE)/Lox.java

clean:
	rm -rf $(BUILDDIR)/*

