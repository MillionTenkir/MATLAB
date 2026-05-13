T = readtable("soft-drinks.xlsx")

disp(head(T))
disp("variables")
disp(T.Properties.VariableNames)

% Contingency table
CT = crosstab(T.Word, T.Brand)

wordcats = categories(categorical(T.Word))
Brandcats = categories(categorical(T.Brand))

CTtable = array2table(CT, 'RowNames',wordcats, 'VariableNames',Brandcats)
disp("Contingency table")
disp(CTtable)

% Chi square
N = sum(CT, 'all');             % total observations
rowSum = sum(CT,2);             % row totals
colSum = sum(CT,1);             % column totals

Expected = (rowSum * colSum) / N;

Chi2stat = sum(((CT - Expected).^2) ./ Expected, 'all');

[r,c] = size(CT);
df = (r-1)*(c-1);

pvalue = 1 - chi2cdf(Chi2stat, df);

disp("Chi-square Statistic:");
disp(Chi2stat);

disp("Degrees of freedom:");
disp(df);

disp("p-value:");
disp(pvalue);