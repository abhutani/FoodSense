mat = csvread('lbp_features.csv');
Y = mat(:, 60);
X = mat(:, 1:59);
Y = categorical(Y);

SVMModel = fitcsvm(X,Y,'KernelFunction','rbf','Standardize',true,'ClassNames',{'0','1'});

%% Test data
he = imread(['1_data set\1_data set\rot\rot (45).jpg']);
cform = makecform('srgb2lab');
lab_he = applycform(he,cform);

ab = double(lab_he(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);

nColors = 3;
% repeat the clustering 3 times to avoid local minima
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean','Replicates',3);

pixel_labels = reshape(cluster_idx,nrows,ncols);
% imshow(pixel_labels,[]), title('image labeled by cluster index');

segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);

for k = 1:nColors
	color = he;
	color(rgb_label ~= k) = 0;
	segmented_images{k} = color;
end

%% Extracting LBP features
segmented_images{1} = rgb2gray(segmented_images{1});
segmented_images{2} = rgb2gray(segmented_images{2});
segmented_images{3} = rgb2gray(segmented_images{3});

LBP_features1 = extractLBPFeatures(segmented_images{1});
LBP_features2 = extractLBPFeatures(segmented_images{2});
LBP_features3 = extractLBPFeatures(segmented_images{3});

%% Testing on model
[label1,score1] = predict(SVMModel,LBP_features1);
[label2,score2] = predict(SVMModel,LBP_features2);
[label3,score3] = predict(SVMModel,LBP_features3);

%% 
subplot(2,3,1);
imshow(segmented_images{1}), title(label1);
btn = uicontrol('Style', 'pushbutton', 'String', '1','Position', [20 20 50 20],'Callback', 'cla');
subplot(2,3,2);
imshow(segmented_images{2}), title(label2);
subplot(2,3,3);
imshow(segmented_images{3}), title(label3);
subplot(2,3,4);
% imshow(segmented_images{4}), title('objects in cluster 4');
% subplot(2,3,5);
imshow(he), title('original');
	