PROG=labgen
OBJ=labgen.l labgen.y
all: $(PROG)   

$(PROG): $(OBJ)
	flex -o lex.yy.c  labgen.l
	bison -o labgen.tab.c labgen.y
	cc -o $(PROG) labgen.tab.c
clean:
	rm lex.yy.c
	rm labgen.tab.c 
 
clean1 :
	rm $(PROG)
