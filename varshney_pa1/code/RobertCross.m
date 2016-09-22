function RobertCross(fileName, color)
%% Robert Cross operator for edge detection %%

filename = fileName;
image=imread(filename);

if(color == 1)
   image=rgb2gray(image);
end

image=double(image);

% kernel matrices
SBx = [+1 0; 0 -1]; 
SBy = [0 1; -1 0];
% zero padding
image=[zeros(size(image,1),1) image zeros(size(image,1),1)];
image=[zeros(size(image,2),1)' ;image; zeros(size(image,2),1)'];
[a,b]=size(image);
% convolution
for i=1:a-1
    for j=1:b-1
        sum_x = 0;
        sum_y = 0;
        for k=1:2
            for l=1:2
                x = SBx(k,l) .* image(i+k-1,j+l-1);
                sum_x = sum_x + x;
                y = SBy(k,l) .* image(i+k-1,j+l-1);
                sum_y = sum_y + y;
            end
        end
            magnitude(i,j) = sqrt(sum_x^2 + sum_y^2);
            direction(i,j) = atan2(sum_y, sum_x);
    end
end

%% Scaling the  magnitude and direction values in 0-255 by normalization

magnitude=scaling(magnitude);
f1= figure('name', 'Robert Cross Edge Detection Magnitude after Scaling'); 
imshow(magnitude); 
saveas(f1, [filename 'RC-MagnitudeScaled.jpg']);

%% Thresholding%%

threshValue = threshold(magnitude);
% setting the values as 255 or 0 to create a binary image
magnitude(magnitude >= threshValue) = 255;
magnitude(magnitude < threshValue) = 0;

f2=figure('name', 'Robert Cross Gradient Magnitude after Thresholding'); 
imshow(magnitude); 
saveas(f2, [filename 'RC-MagnitudeThresholded.jpg']);

threshValue = threshold(direction);
direction(direction >= threshValue) = 255;
direction(direction < threshValue) = 0;

f3=figure('name','Robert Cross Gradient Direction after Thresholding');
imshow(direction); 
saveas(f3, [filename 'RC-DirectionThresholded.jpg']);

%% edge thinning

% do expansion before thinning
magnitude=expansion(magnitude./255);
f4=figure('name','Robert Cross Magnitude (Binary & Expanded) without thinning');
imshow(magnitude); 
saveas(f4, [filename 'RC-ExpandedBinary.jpg']);

tic;
ZSthinned = thinning1(magnitude);
t1=toc;
fprintf('timespent for ZS %f \n' , t1);

f5=figure('name','Robert Cross Edge Detection with ZS thinning');
imshow(ZSthinned);
saveas(f5, [filename 'RC-ZS_Thinning.jpg']);

tic;
GHthinned = thinning2(magnitude);
t2=toc;
fprintf('timespent for GH %f \n' , t2-t1);

f6=figure('name',' Robert Cross Edge Detection with GH thinning');
imshow(GHthinned);
saveas(f6, [filename 'RC-GH_Thinning.jpg']);
end
