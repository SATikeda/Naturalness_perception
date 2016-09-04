/////////////////////////
 File/folder description
/////////////////////////

	* images/		  			    Folder to contain image data.
	
	* data/

		- getData.m:				Runnable script to get images from images/ folder 
									and make data.mat file

		- getImages.m				Function to get image data from images/ folder

	* tool/							Folder for tools. libsvm-3.21 should be placed in this folder

	* features/			

		- makeFeature_baseline.m	Runnable script to get features for baseline method
						
		- makeFeatures_fact2.m		Runnable script to get features for second order factorization

		- makeFeatures_fact3.m		Runnable script to get features for our method


	* src/baseline

		- getFeaturesBL.m			Function to get features for baseline method

		- getFlatSamplesBL.m		Function to get samples from flat region

		- getEdgeSamplesBL.m		Function to get samples from edge region

		- calcHistBL.m				Function to calculate histogram

		- rgb2yuv4D.m				Function to convert rgb data to yuv data


	* src/ourmethod

		- getFeatures.m				Function to get features for our method

		- getFlatSamples.m			Function to get samples from flat region

		- getEdgeSamples.m			Function to get samples from edge region

		- calcHist3combBits.m		Function to calculate histogram with multiple intensity levels

		- myRgb2yuv.m				Function to convert rgb data to yuv data


	* src/2factorization

		- getFeatures_2fact.m		Function to get features for second order factorizatin method

		- getFlatSamples.m			Function to get samples from flat region

		- getEdgeSamples.m			Function to get samples from edge region

		- calcHist2combBits.m		Function to calculate histogram with multiple intensity levels

		- myRgb2yuv.m				Function to convert rgb data to yuv data


	* exp/exp_woPCA

		- calcAcc.m					Functin to calculate accuracy

		- doSVM_cls.m				Function to do cross validation by SVM

		- findPrm.m					Function to find the best parameter for SVM

		- makeX.m					Function to make feature matrix

		-run_CV.m					Runnable code to do the experiment without PCA


	* exp/exp_withPCA

		- calcAccPCA.m				Functin to calculate accuracy

		- doSVM_PCA.m				Function to do cross validation by SVM

		- findPrm_PCA.m				Function to find the best parameter for SVM

		- makeX.m					Function to make feature matrix

		- pca.m						Function to apply Principal Component Analysis

		-run_CV.m					Runnable code to do the experiment with PCA


	* exp/NSSanalysis
		
		- calcHist3comb.m			Function to calculate histogram

		- makeFeatures.m			Runnable code to extract features

		- calcVariance.m			Runnable code to calculate variance of probability

		- plot_shape.m				Plot the obtained patch shape


/////////////////////////
 How to run the code
/////////////////////////

1. Place images to images/ folder from http://www1.i2r.a-star.edu.sg/~ttng/VisualRealism/index.html

2. Place libsvm-3.21 to tool/ folder

3. Make data.mat

	>> getData

4. Make features

	>> makeFeatures_baseline
	>> makeFeatures_fact2
	>> makeFeatures_fact3

5. Run experiments

	>> run_CV

