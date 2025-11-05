.POSIX:

JAVAC         = javac
CFLAGS        = -Werror -d $(BUILDDIR) -cp $(SRCDIR)

TARGET        = Lox.jar
PREFIX        = /usr/local
SRCDIR        = src
BUILDDIR      = build

PACKAGE       = com/craftinginterpreters/lox

SRCFILES      = $(SRCDIR)/$(PACKAGE)/Lox.java \
                $(SRCDIR)/$(PACKAGE)/TokenType.java \
                $(SRCDIR)/$(PACKAGE)/Token.java \
                $(SRCDIR)/$(PACKAGE)/Scanner.java

BUILDCLASSES  = $(BUILDDIR)/$(PACKAGE)/Lox.class \
                $(BUILDDIR)/$(PACKAGE)/TokenType.class \
                $(BUILDDIR)/$(PACKAGE)/Token.class \
                $(BUILDDIR)/$(PACKAGE)/Scanner.class

$(BUILDDIR)/$(TARGET): $(BUILDCLASSES)
	jar cfe $@ $(PACKAGE)/Lox -C $(BUILDDIR) .

$(BUILDCLASSES): $(SRCFILES)
	$(JAVAC) $(CFLAGS) $(SRCFILES)

clean:
	rm -rf $(BUILDDIR)

