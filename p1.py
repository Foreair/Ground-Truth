import numpy as np
import glob
from scipy import misc
from PIL import Image
from os import listdir
import matplotlib.pyplot as plt
import matplotlib.cm as cm

train_path = "C:/Users/josem/Documents/UAB/Practicas Uni/Visio/practiques/p1/highway/input/Train/"
test_path = "C:/Users/josem/Documents/UAB/Practicas Uni/Visio/practiques/p1/highway/input/Test/"

trainFiles = glob.glob(train_path + "*.jpg")
testFiles = glob.glob(test_path + "*.jpg")
numTrainFiles = len(trainFiles)
numTestFiles = len(testFiles)

#img = misc.imread(train_path + 'in001058.jpg', 1)
imgArray = np.empty([numTrainFiles, 240, 320])

for i, name in enumerate(trainFiles):
	img = misc.imread(name, 1)
	imgArray[i] = img

meanImg = imgArray.mean(0)
stdImg = imgArray.std(0)


# LLINDAR SIMPLE
imgTestArray = np.empty([numTestFiles, 240, 320])
for i, name in enumerate(testFiles):
	img = misc.imread(name, 1)
	resImg = abs(meanImg - img) > 35
	imgTestArray[i] = resImg


# LLINDAR GAUSS
imgTestGaussArray = np.empty([numTestFiles, 240, 320])
alpha = 1;
beta = 0;
for i, name in enumerate(testFiles):
	img = misc.imread(name, 1)
	resImg = abs(img - meanImg) > alpha * (stdImg + beta);
	imgTestGaussArray[i] = resImg


plt.imshow(imgTestGaussArray[124], cm.Greys_r)
plt.imshow(imgTestArray[124],cm.Greys_r)
plt.show()

