function [Hough, theta_range, rho_range] = hough_transform_line(mag, image)
%% This is the code for the detection lines using Hough Transform. 
% as taught in the class!
[rows, cols] = size(mag);
theta_maximum = 90;
rho_maximum = round(sqrt(rows^2 + cols^2));
theta_range = -theta_maximum+1:theta_maximum;
rho_range = -rho_maximum +1:rho_maximum;

Hough = zeros(length(rho_range),length(theta_range));
 
for row = 2: rows-1
    for col = 2: cols-1
        if mag(row, col) > 0
            for theta = theta_range
                rho = ((col-1) * cosd(theta)) + ((row-1) * sind(theta));                   
                rho_index = round(rho) + rho_maximum;
                theta_index = round((theta+90));
                Hough(rho_index, theta_index) = Hough(rho_index, theta_index) + 1;
            end
        end
    end
end

f1=figure('name', 'Line Hough Transform plot'); 
imshow(imadjust(mat2gray(Hough)), [], 'XData', theta_range, 'YData', rho_range, 'InitialMagnification', 'fit');
xlabel('\theta (degrees)'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(hot);
saveas(f1, 'line_houghTransform.jpg');

%% detect peaks in hough transform
r_row = [];
c_col = [];

[max_val, row_index] = max(Hough);
[~, cols] = size(mag);
% this should vary according the number of lines probably
% a lot of this depends on the theta variation too. If theta variation is
% set to 0.1 instead by 1 degrees, we need to define this more precisely. 
threshold = 0.4 * max(max_val);
for i = 1: length(max_val)
   if max_val(i) > threshold
       c_col = [c_col i];
       r_row = [r_row row_index(i)];
   end
end

%% now plot all the detected peaks on hough transform image
plot(theta_range(c_col), rho_range(r_row),'s', 'color', 'black','LineWidth',2);
hold off;
%% plot the detected lines superimposed on the original image
f2=figure('name', 'super imposed lines detected by Hough Transforms');
imshow(image);

hold on;
for i = 1: length(c_col)
    theta_line = theta_range(c_col(i));
    rho_line = rho_range(r_row(i));
    b = rho_line/sind(theta_line);
    x = 2:cols-1;
    m = -(cosd(theta_line)/sind(theta_line));
    plot(x-1, m*(x-1)+b);
    disp ([m b]);
    hold on;
end
hold off;
saveas(f2, 'line_houghTransform_superimposed.jpg');
end
