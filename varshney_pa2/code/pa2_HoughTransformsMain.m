function pa2_HoughTransformsMain(filename, color, isLine)

image=imread(filename);

if(color)
   image=rgb2gray(image);
end

image=double(image);

thinned_image=Sobel(image); 

%% Hough Transform
if (isLine)
	hough_transform_line(thinned_image, image);
else
	hough_transform_ellipse(thinned_image);
end
