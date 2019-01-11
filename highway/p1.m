%TRAIN
path = 'C:\Users\David\Desktop\dataset\train\';
files = dir(strcat(path, '*.jpg'));

imgArray = imread(strcat(path, files(1).name));
for i=2:150
	aux = strcat(path, files(i).name);
	imgArray = cat(3, imgArray, rgb2gray(imread(aux)));
end

img_mean = mean(imgArray, 3);
img_mean_norm = mat2gray(img_mean);

img_std = std(imgArray, 0, 3);
img_std_norm = mat2gray(img_std);

%TEST
path = 'C:\Users\David\Desktop\dataset\test\';
test_files = dir(strcat(test_path, '*.jpg'));

testImgArray = imread(strcat(test_path, test_files(1).name));
for i=2:150
	aux = strcat(test_path, test_files(i).name);
	testImgArray = cat(3, testImgArray, rgb2gray(imread(aux)));
end


%1.4.3
[sz1, sz2] = size(img_mean)
im_zeros = zeros(sz1, sz2);
im_ones = ones(sz1, sz2);
%im_res = im > 35;

%Segmentacio gaussiana
%im es una imatge triada a l'atzar d'entre les de test. TODO: fer-ho amb totes les imatges de test
im_gauss = abs(im - img_mean) > alpha * (img_std + beta);