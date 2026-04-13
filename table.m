% Create two 3x3 numeric arrays
A = randi(9,3,3);   % integers 1..9
B = randi(9,3,3);

% Convert to tables with 3 column names
T1 = array2table(A, 'VariableNames', {'C1','C2','C3'});
T2 = array2table(B, 'VariableNames', {'C1','C2','C3'});

T1.xx=["aaa"; "bbb";"ccc"]
T2.xx=["xx";"yy";"zz"]


T1.yy=['aaa'; 'bbb';'ccc']
T2.yy=[1;2;3]

T1.zz=["a";"b";"c"]


% Add the tables element-wise (works because corresponding variables are numeric)
Tsum = T1 + T2;

% Display
T1
T2
Tsum
