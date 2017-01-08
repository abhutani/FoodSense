featureMatrix = readtable('C:\Users\Gaurav\Documents\FoodSense\lbp_features.csv');

%% PCA 
featureMatrix = table2array(featureMatrix);
[~,scores,latent,~,explained,~] = pca(featureMatrix(:, 1:59));

%% Reduction
numofFeatures = 3;
reducedFeatureMatrix=scores(:, 1:numofFeatures);
labels = featureMatrix(:, 60);
plot(reducedFeatureMatrix(:,1),labels,'r^');

%% Data formatting for Mehta

newFM = [];
newFM = [labels];

for i = 1:59
	s = [];
	for j = 1:1344
		s1 = strcat(num2str(i), ':');
		s = [s s1];
	end
	w = strcat(s, num2str(featureMatrix(:, i)));
	newFM = [newFM w];
end
	