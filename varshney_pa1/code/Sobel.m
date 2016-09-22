function ZSthinned=Sobel(image)
%% Sobel operator for edge detection %%
% 
% filename = fileName;
% image=imread(filename);
% 
% if(color == 1)
%    image=rgb2gray(image);
% end
% 
% image=double(image);
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
saveas(f5, [filename 'Sobel-ZS_Thinning.jpg']);
 
% GHthinned = thinning2(magnitude);
% t2=toc;
% fprintf('timespent for GH %f \n' , t2-t1);
% 
% f6=figure('name', 'Sobel Edge Detection with GH thinning');
% imshow(GHthinned);
% saveas(f6, [filename 'Sobel-GH_Thinning.jpg']);
%% Hough Transform
% [H, theta, rho]=houghTransform(magnitude);
[H, theta, rho]=hough_transform_line(ZSthinned, image);
%ellipse=hough_transform_ellipse(ZSthinned, image);
%[H, theta, rho]=baija001_pa2_code(ZSthinned, image);
% 
% % Display the transform
% figure; 
% imshow(imadjust(mat2gray(H)), [], 'XData', theta, 'YData', rho, 'InitialMagnification', 'fit');
% xlabel('\theta (degrees)'), ylabel('\rho');
% axis on, axis normal, hold on;
% colormap(hot); 
% 
% 
% % Find the peaks in the Hough transform matrix H
% P = houghpeaks(H, 20, 'threshold', ceil(0.3*max(H(:))));
% 
% % Superimpose the location of the peaks onto the transform display
% x = theta(P(:,2));
% y = rho(P(:,1));
% plot(x, y, 's', 'color', 'black');
% 
% 
% % Find the lines in the image
% binary_img=magnitude;
% lines = houghlines(binary_img, theta, rho, P, 'FillGap', 5, 'MinLength', 7);
% img=image;
% % Create a plot that superimposes the lines onto the original image
% figure; 
% imshow(img); 
% hold on;
% max_len = 0;
% for k = 1:length(lines)
%     xy = [lines(k).point1; lines(k).point2];
%     plot(xy(:,1), xy(:,2), 'LineWidth', 2, 'Color', 'green');
% 
%     % Plot beginnings and ends of lines
%     plot(xy(1,1), xy(1,2), 'x', 'LineWidth', 2, 'Color', 'yellow');
%     plot(xy(2,1), xy(2,2), 'x', 'LineWidth', 2, 'Color', 'red');
% 
%     % Determine the endpoints of the longest line segment
%     len = norm(lines(k).point1 - lines(k).point2);
%     if (len > max_len)
%         max_len = len;
%         xy_long = xy;
%     end
% end
% 
% % Highlight the longest line segment
% plot(xy_long(:,1), xy_long(:,2), 'LineWidth', 2, 'Color', 'red');
end