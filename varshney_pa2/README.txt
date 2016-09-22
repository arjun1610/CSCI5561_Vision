Name- Arjun Varshney
ID - 5215383

The submission contains three folders and two files namely, 
a) 'code' containing all the relevant matlab code files for this assignment. 
b) 'test_results' containing the results of the test_images used 
c) 'test_images' containing the test images to test the edge detection
d) CSCI5561ProgrammingAssignment1Report_ArjunVarshney.pdf having the discussion of results
e) README.txt (this file)

SEQUENCE OF EVENTS IN THE CODE

For Line Detection following is the sequence of events in the code:
1) Get the input as thinned image using the last programming assignment. 
2) Create accumulator array with rho, theta values.
3) Find maximum votes with minimum threshold, (to get hough peaks) implementation of houghpeaks
4) Once we have hough peaks, using the values of rho, theta at those points, get the equation of lines and plot them on the original image. (implementation of houghlines) 

For Ellipse Detection following is the sequence of events in the code:
1) Get the input as thinned image using the last programming assignment
2) Set the parameters for minimum votes( depends on the image) and the min_A, initializing the accumulator array with possible B values
3) Start the Hough Transform technique using three points technique, to calculate the semi major and semi minor axes values. Get the best ellipse using maximum voting on the b values, Get the best fitted ellipse using maximum votes on the best ellipses. 
4) Once a best fit ellipse is detected, find the range of edge pixels which are covered and delete those pixels from the coordinate array containing edge pixels coordinates. This step reduces further computation for finding similar ellipse as we assume that at this point we have found the best ellipse. 
5) Print the predicted ellipse on the image. 



HOW TO COMPILE THE CODE:

You need to run Matlab UI 

1. Run pa2_HoughTransformsMain.m with input params as (filename, color, isLine) where filename should have <filename> and color should have boolean value (if RGB 1 else 0), and isLine if input image has lines then 1, and if ellipses then 0. 
If an image contains both ellipse and lines we need to tweak some lines, to call both the functions (hough_transform_line and hough_transform_ellipse).

Example: On the matlab console, to run the code for lines we type,

pa2_HoughTransformsMain('line1.jpg',1,1);  
where 'lena.png' is the filename and 1 is because the image has RGB values, and other 1 as it is line image


Example: On the matlab console, to run the code for ellipse we type,

pa2_HoughTransformsMain('ellipse1.jpg',1, 0);  
where 'lena.png' is the filename and 1 is because the image has RGB values, and other 0 as it is not a line image.


2. I have included 2 test images as given by you for the assignment.

3. While running you should get figures. Each figure should have a figure title, which would depict the result.
For line, 
We have three images in the output. 
1) Input thinned image.
2) Hough Transform, with Hough Peaks
3) SuperImposed Detected lines on the original image

For Ellipse,
We have multiple images in the output
1) Input thinned image, 
2) Best Detected ellipses - one by one figures comes up. 
3) Plot the cumulative ellipses figures onto the thinned image for superimposing.

Things to ponder for ellipse: 
1) The theta values differ by 1 in the code. If I change it to 0.5 or lesser, we see multiple lines having similar votes, due to the reason that our Hough Space is larger with minimal difference, and the edges for a single line are actually two. So microscopically, we have two lines very near to each other. So if our Hough Space is very large, we are bound to get those lines detected. Otherwise, the lines would generally be single as we are rounding off R to some extent with discrete values of theta. 

2) The ellipse code has many constraints. We are applying more and more constraints or conditions to reduce the ellipse space from being detected. Here in this assignment, we know that all the ellipses are parallel to x-axis (semi-major axes parallel to x-axis) so I have put a condition of detecting only those kind of ellipses to reduce the computation time. We can get similar results without having that constraint too but we have numerous ellipses with slight angles (alpha = -0.05) which also gets required minimum votes. This further makes the things complex, as for each first point we now have to calculate the best ellipse which would get maximum votes, but we don't know when the best ellipse is found and then when to delete the pixels to reduce computation. I think if gradient direction comes into play here, it would help us know if we are at the local maximum for getting the best ellipse. A good algorithm can be devised here for this. 

4. The figures are also saved in the present working directory with the appropriate name appended to it.


