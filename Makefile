.POSIX:

JAVAC         = javac
CFLAGS        = -Werror -d $(BUILDDIR) -cp $(SRCDIR)

TARGET        = Lox.jar
PREFIX        = /usr/local
SRCDIR        = src
BUILDDIR      = build

PACKAGEPATH   = com/craftinginterpreters
PACKAGELOX    = $(PACKAGEPATH)/lox
PACKAGETOOL   = $(PACKAGEPATH)/tool

SRCFILES      = $(SRCDIR)/$(PACKAGELOX)/Lox.java \
                $(SRCDIR)/$(PACKAGELOX)/TokenType.java \
                $(SRCDIR)/$(PACKAGELOX)/Token.java \
                $(SRCDIR)/$(PACKAGELOX)/Scanner.java \
                $(SRCDIR)/$(PACKAGELOX)/Expr.java \
                $(SRCDIR)/$(PACKAGELOX)/Stmt.java \
                $(SRCDIR)/$(PACKAGELOX)/Parser.java \
                $(SRCDIR)/$(PACKAGELOX)/Interpreter.java \
                $(SRCDIR)/$(PACKAGELOX)/RuntimeError.java \
                $(SRCDIR)/$(PACKAGELOX)/Environment.java

BUILDCLASSES  = $(BUILDDIR)/$(PACKAGELOX)/Lox.class \
                $(BUILDDIR)/$(PACKAGELOX)/TokenType.class \
                $(BUILDDIR)/$(PACKAGELOX)/Token.class \
                $(BUILDDIR)/$(PACKAGELOX)/Scanner.class \
                $(BUILDDIR)/$(PACKAGELOX)/Expr.class \
                $(BUILDDIR)/$(PACKAGELOX)/Stmt.class \
                $(BUILDDIR)/$(PACKAGELOX)/Parser.class \
                $(BUILDDIR)/$(PACKAGELOX)/Interpreter.class \
                $(BUILDDIR)/$(PACKAGELOX)/RuntimeError.class \
                $(BUILDDIR)/$(PACKAGELOX)/Environment.class

$(BUILDDIR)/$(TARGET): $(BUILDCLASSES)
	jar cfe $@ $(PACKAGELOX)/Lox -C $(BUILDDIR) .

$(BUILDCLASSES): $(SRCFILES)
	$(JAVAC) $(CFLAGS) $(SRCFILES)

$(BUILDDIR)/$(PACKAGETOOL)/GenerateAst.class: $(SRCDIR)/$(PACKAGETOOL)/GenerateAst.java
	$(JAVAC) $(CFLAGS) $(SRCDIR)/$(PACKAGETOOL)/GenerateAst.java

$(SRCDIR)/$(PACKAGELOX)/Expr.java: $(BUILDDIR)/$(PACKAGETOOL)/GenerateAst.class
	java -cp $(BUILDDIR) $(PACKAGETOOL)/GenerateAst $(SRCDIR)/$(PACKAGELOX)

$(SRCDIR)/$(PACKAGELOX)/Stmt.java: $(BUILDDIR)/$(PACKAGETOOL)/GenerateAst.class
	java -cp $(BUILDDIR) $(PACKAGETOOL)/GenerateAst $(SRCDIR)/$(PACKAGELOX)

$(BUILDDIR)/$(PACKAGELOX)/AstPrinter.class: $(SRCDIR)/$(PACKAGELOX)/AstPrinter.java $(BUILDCLASSES)
	$(JAVAC) $(CFLAGS) $(SRCDIR)/$(PACKAGELOX)/AstPrinter.java

print_ast: $(BUILDDIR)/$(PACKAGELOX)/AstPrinter.class
	java -cp $(BUILDDIR) $(PACKAGELOX)/AstPrinter

clean:
	rm -rf $(BUILDDIR) $(SRCDIR)/$(PACKAGELOX)/Expr.java $(SRCDIR)/$(PACKAGELOX)/Stmt.java

