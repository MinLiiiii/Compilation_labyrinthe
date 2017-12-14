%option noyywrap

%%


N|NE|E|SE|S|SW|W|BW  { return DIR; }
;  { return FIN; }
SIZE { return SIZE; }
IN   { return IN; }
OUT  { return OUT; }
WALL { return WALL; }
UNWALL { return UNWALL; }
TOGGLE { return TOGGLE; }
PTA { return PTA; }
PTD  { return PTD; }
R    { return R; }
F    { return F; }
FOR  { return FOR; }
WH   { return WH; }
MD   { return MD; }
SHOW { return SHOW;}
[,]  { return vir; }
[=]  { return e;}
[(]  { return paren_left; }
[)]  { return paren_right; }
[+]  { return plus; }
[/]  { return division;}
[-]  { return sous;}
[%]  { return mod;}
[*]  { return mult; }
[>]  { return sup; }
[#]  { return com; }
[0-9]+           { return NUM; }
max   { return max;}
[a-zA-Z_][a-zA-Z_0-9]* { return IDENT; }

