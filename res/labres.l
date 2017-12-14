%option noyywrap

%%

[N] { return N; }
[S] { return S; }
[E] { return E; }
[W] { return W; }
[\n] {++linenum;} 
EOF { return END; }
[\t]* {}
