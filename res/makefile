PROG1=labres
OBJ1=labres.l labres.y
all: $(PROG1)   

$(PROG1): $(OBJ1)
	flex -o lex1.yy.c labres.l 
	bison -o labres.tab.c labres.y 
	cc -o $(PROG1) labres.tab.c
clean:
	rm lex1.yy.c
	rm labres.tab.c  
 
clean1 :
	rm $(PROG1)