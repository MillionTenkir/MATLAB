X = readtable("filename.xls","Sheet","Sheet1","ReadRowNames",true,"ReadVariableNames",true);

bool1=(string(X.Gender))=="Female";
bool2=X.Age>=25 & X.Age<=40;
bool3 = bool1 & bool2;
resultTable = X(bool3, {'Id', 'Gender', 'Age'});

bool3=bool1 & bool2
[X.Id bool1 bool2 bool3]