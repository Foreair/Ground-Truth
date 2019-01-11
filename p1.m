%TRAIN
path = 'C:\Users\Forgotten Knight\Desktop\Uni\Tercer\Semestre2\Visio\Practiques\P1\highway\input\Train\';
files = dir(strcat(path, '*.jpg'));

imgArray = rgb2gray(imread(strcat(path, files(1).name)));
for i=2:150
	aux = strcat(path, files(i).name);
	imgArray = cat(3, imgArray, rgb2gray(imread(aux)));
end

img_mean = mean(imgArray, 3);
img_mean_norm = mat2gray(img_mean);

imgArray2=double(imgArray);
img_std = std(imgArray2, 0, 3);
img_std_norm = mat2gray(img_std);

%TEST
test_path = 'C:\Users\Forgotten Knight\Desktop\Uni\Tercer\Semestre2\Visio\Practiques\P1\highway\input\Test\';
test_files = dir(strcat(test_path, '*.jpg'));

% testImgArray = rgb2gray(imread(strcat(test_path, test_files(1).name)));
% for i=2:150
% 	aux = strcat(test_path, test_files(i).name);
% 	testImgArray = cat(3, testImgArray, rgb2gray(imread(aux)));
% end


%1.4.3
%im=double(rgb2gray(imread('C:\Users\Forgotten Knight\Desktop\Uni\Tercer\Semestre2\Visio\Practiques\P1\highway\input\Train\in001079.jpg')));
%[sz1, sz2] = size(img_mean)
%im_zeros = zeros(sz1, sz2);
%im_ones = ones(sz1, sz2);
%im_res = im < 75;

llindar = 35;
aux=double(rgb2gray(imread(strcat(test_path, test_files(1).name))));
auxRes= abs(aux- img_mean) > llindar;
imgArrayTest = auxRes;
movie = VideoWriter('videoTest.avi');
movie.FrameRate = 25;
open(movie);
auxRes=double(auxRes);
writeVideo(movie, auxRes);
for i=2:150
	aux = double(rgb2gray(imread(strcat(test_path, test_files(i).name))));
    auxRes = abs(aux- img_mean) > llindar;
	imgArrayTest = cat(3, imgArrayTest, auxRes);
    auxRes=double(auxRes);
    writeVideo(movie, auxRes);
end
close(movie);

%Segmentacio gaussiana
%im es una imatge triada a l'atzar d'entre les de test. TODO: fer-ho amb totes les imatges de test

alpha=0.75;
beta=50;

aux=double(rgb2gray(imread(strcat(test_path, test_files(1).name))));
im_gauss = abs(aux - img_mean) > alpha * (img_std + beta);
imgArrayTestGauss = im_gauss;


movie = VideoWriter('videoGauss.avi');
movie.FrameRate = 25;
open(movie);
im_gauss= double(im_gauss);
writeVideo(movie, im_gauss);

for i=2:150
	aux = double(rgb2gray(imread(strcat(test_path, test_files(i).name))));
    im_gauss = abs(aux - img_mean) > alpha * (img_std + beta);
    im_gauss= double(im_gauss);
	%imgArrayTestGauss = cat(3, imgArrayTestGauss, im_gauss);
    writeVideo(movie, im_gauss);
    
end


%imshow([imgArrayTestGauss(:,:,2) imgArrayTestGauss(:,:,100)]);

im_zeros = zeros(240, 320);
close(movie);
    

%im_zeros== imgArrayTestGauss(:,:,2) - imgArrayTestGauss(:,:,100)

