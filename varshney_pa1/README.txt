Name- Arjun Varshney


The submission contains three folders and two files namely, 
a) 'code' containing all the relevant matlab code files for this assignment. 
b) 'test_results' containing the results of the test_images used 
c) 'test_images' containing the test images to test the edge detection
d) CSCI5561ProgrammingAssignment1Report_ArjunVarshney.pdf having the discussion of results
e) README.txt (this file)

SEQUENCE OF EVENTS IN THE CODE

For both the Sobel and Robert Cross Edge operators, following is the sequence of events,
a) Do Zero padding, and then convolve Edge Operator (Sobel or Robert Cross)
b) Do Scaling of the results (Scaling here is done for the gradient magnitude and not for the gradient direction)
c) Do thresholding of the gradient magnitude and direction
d) Do Expansion of the magnitude before thinning 
e) Do thinning by Zhang Suen thinning Algorithm
f) Do thinning by Guo Hall thinning Algorithm

HOW TO COMPILE THE CODE:

You need to run Matlab UI 

1. Run Sobel.m and RobertCross.m with input params as (filename, color) where filename should have <filename> and color should have boolean value (if RGB -1 else 0)

Example: On the matlab console, to run the code for Robert Cross we type

RobertCross('lena.png',0);  
where 'lena.png' is the filename and 0 is because the image is already a grayscale image

On the matlab console, to run the code for Sobel we type 

Sobel('demo1.png',1);
where 'demo1.png' is the filename and 1 is because the image is an RGB image

2. I have included 4 test images (two Grayscale and two RGB) for which to run these images you need to run the following commands, 

Sobel('lena.png',0);
RobertCross('lena.png',0);  

Sobel('findsuits.jpg', 0);
RobertCross('findsuits.jpg', 0); 

Sobel('demo1.png',1);
RobertCross('demo1.png',1);

Sobel('cameraman.jpg',1);
RobertCross('cameraman.jpg',1);


3. You should get 6 figures, Each figure should have a figure title, which would depict the result.

1. Gradient Magnitude after Scaling
2. Gradient Magnitude after thresholding
3. Gradient Direction after thresholding
4. Gradient Magnitude after Expansion and Binary 
5. Gradient Magnitude after thinning with Zhang Suen Algorithm 
6. Gradient Magnitude after thinning with Guo Hall Algorithm 

4. The figures are also saved in the present working directory with the appropriate name appended to it.

