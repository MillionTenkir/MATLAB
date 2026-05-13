T = readtable("wafer.txt");

n = height(T)
% disp("W"+string(1:n))
% give row names
T.Properties.RowNames = "W"+string(1:n)

disp(T)

% Show the parallel coordinates
figure;
parallelcoords(table2array(T), 'Labels',T.Properties.VariableNames);
title('Parallel Coordinates Plot of Wafer Data');
xlabel('Features');
ylabel('Values');

% Prepare data for scatterplot matrix
X = table2array(T);
varNames = T.Properties.VariableNames;

figure;
plotmatrix(X);
sgtitle("Scatterplot")

% Correlation matrix
R = corr(X);
disp("Correlation matrix");
disp(array2table(R, 'VariableNames', varNames, 'RowNames', varNames))

% Dimensionality Reduction (PCA), Covariance and correlation matrix
% Covariance matrix
S = cov(X)
disp("Covariance Matrix")
disp(array2table(S, 'VariableNames',varNames, 'RowNames',varNames))

% PCA using correlation matrix
Z = zscore(X) % -> Standardize (mean = 0, std =1)
[coeff, score, latent, tsquared, explained]=pca(Z)

% coeff = eigenvectors (loadings directions)
% score = PC scores (new coordinates of wafers)
% latent = eigenvalues
% explained = percentage variance explained

disp("Eigenvalues (latent)")
disp(latent)

disp("Explained variance percentage")
disp(explained)

% Condition and equation eigenvalues
% |R = lambdaI| =0
syms lambda;

Rmat = corr(X);
I = eye(size(Rmat))

charPoly = det(Rmat - lambda*I)
disp("Characteristic Polynomial:");
pretty(expand(charPoly))

charPolyExpanded = expand(charPoly);
eigValues = solve(charPolyExpanded == 0, lambda);
eigValuesApprox = vpa(eigValues, 3);

disp("Eigenvalues (symbolic, 3 decimals):");
disp(eigValuesApprox);

% Percentage of variance explained 
explainedVar = explained;
cumExplained = cumsum(explainedVar);

ResultTable = table(explainedVar, cumExplained, 'VariableNames', {'RelativeVariance_%', 'CumulativeVariance_%'});
disp("Variance Explained Table:");
disp(ResultTable);

% Plot explained variance
figure;
pareto(explained);
title("Pareto plot of variance explained")
xlabel("principal component")
ylabel("variance explained")
grid on;

% help me create kaiser criterion
disp("Eigenvalues (latent):");
disp(latent);

k = sum(latent > 1);
disp("Number of PCs with eigenvalue > 1:");
disp(k);

% correlation between PCs and original variables
corrPC = corr(Z, score)
disp("Correlation between original variables and PCs: ")
disp(array2table(corrPC, 'RowNames',varNames))

% Verify sum of squared correlation equlas eigenvalues
sumSqCorr = sum(corrPC.^2)
disp(sumSqCorr);

disp("Eigenvalues from PCA:");
disp(latent');
disp("Difference (should be near zero):");
disp(sumSqCorr - latent');

% Biplot representation + scores interpretation
figure;
biplot(coeff(:,1:2), 'Scores', score(:,1:2), 'VarLabels', varNames);
title("Biplot (PC1 vs PC2)");
grid on;

%Scree plot
figure;
plot(latent, '-o');
title("Scree Plot");
xlabel("Principal Component");
ylabel("Eigenvalue");
grid on;

% Score plot
figure;
scatter(score(:,1), score(:,2), 100, 'filled');
text(score(:,1), score(:,2), T.Properties.RowNames, 'VerticalAlignment','bottom');
title("Score Plot (PC1 vs PC2)");
xlabel("PC1");
ylabel("PC2");
grid on;