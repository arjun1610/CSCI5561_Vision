function ZSthinned = Sobel(image)
%% Sobel operator for edge detection %%

% zero padding
image=[zeros(size(image,1),1) image zeros(size(image,1),1)];
image=[zeros(size(image,2),1)' ;image; zeros(size(image,2),1)'];
% kernel matrices
SBy = [-1 -2 -1; 0 0 0; +1 +2 +1]; 
SBx = SBy';

[a,b]=size(image);
% convolution
for i= 1: a-2
    for j= 1: b-2
        sum_x = 0;
        sum_y = 0;
        for k= 1:3
            for l= 1:3
                x = SBx(k,l) .* image(i+k-1,j+l-1);
                sum_x = sum_x + x;
                y = SBy(k,l) .* image(i+k-1,j+l-1);
                sum_y = sum_y + y;
            end
        end
            magnitude(i,j)= sqrt(sum_x^2+sum_y^2);           
            direction(i,j)= atan2(sum_y,sum_x);
    end
end

%% Scaling the  magnitude and direction values in 0-255 by normalization

magnitude=scaling(magnitude);
% f1=figure('name', 'Sobel Edge Detection Magnitude after Scaling'); 
% imshow(magnitude); 
% saveas(f1, [filename 'Sobel-MagnitudeScaled.jpg']);

%% Thresholding%%

threshValue = threshold(magnitude);
% setting the values as 255 or 0 to create a binary image
magnitude(magnitude >= threshValue) = 255;
magnitude(magnitude < threshValue) = 0;

% f2=figure('name', 'Sobel Gradient Magnitude after Thresholding'); 
% imshow(magnitude); 
% saveas(f2, [filename 'Sobel-MagnitudeThresholded.jpg']);

threshValue = threshold(direction);
direction(direction >= threshValue) = 255;
direction(direction < threshValue) = 0;

% f3=figure('name','Sobel Edge Gradient Direction after Thresholding');
% imshow(direction); 
% saveas(f3, [filename 'Sobel-DirectionThresholded.jpg']);

%% edge thinning
% 
% % do expansion before thinning
%magnitude=expansion(magnitude./255);
% f4=figure('name', 'Sobel Magnitude (Binary and Expanded) without thinning');
% imshow(magnitude); 
% saveas(f4, [filename 'Sobel-ExpandedBinary.jpg']);
tic;
ZSthinned = thinning1(magnitude);
t1=toc;
fprintf('timespent for ZS %f \n' , t1);

f5=figure('name', 'Sobel Edge Detection with ZS thinning');
imshow(ZSthinned);
saveas(f5, 'Sobel-ZS_Thinning.jpg');
end
