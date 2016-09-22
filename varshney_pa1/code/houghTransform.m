function [Hough, theta_range, rho_range] = houghTransform(mag)
[rows, cols] = size(mag);
 
    theta_maximum = 90;
    rho_maximum = floor(sqrt(rows^2 + cols^2)) - 1;
    theta_range = -theta_maximum:theta_maximum - 1;
    rho_range = -rho_maximum:rho_maximum;
 
    Hough = zeros(length(rho_range),length(theta_range));
 
    for row = 1:rows
        for col = 1:cols
            if mag(row, col) > 0
                x = col - 1;
                y = row - 1;
                for theta = theta_range
                    rho = round((x * cosd(theta)) + (y * sind(theta)));                   
                    rho_index = rho + rho_maximum + 1;
                    theta_index = theta + theta_maximum + 1;
                    Hough(rho_index, theta_index) = Hough(rho_index, theta_index) + 1;
                end
            end
        end
    end
    
%     close(wb);

% figure;
% hold on;
% subplot(1,2,1);
% imagesc(theta_range, rho_range, Hough);
% title('Hough Transform');
% xlabel('Theta (degrees)');
% ylabel('Rho (pixels)');
% colormap('gray');
% hold off;
%% detect peaks in hough transform
% r = [];
% c = [];
% [max_in_col, row_number] = max(Hough);
% [rows, cols] = size(mag);
% difference = 25;
% thresh = max(max(Hough)) - difference;
% for i = 1:size(max_in_col, 2)
%    if max_in_col(i) > thresh
%        c(end + 1) = i;
%        r(end + 1) = row_number(i);
%    end
% end
% 
% %% plot all the detected peaks on hough transform image
% hold on;
% plot(theta_range(c), rho_range(r),'rx');
% hold off;
% 

% %% plot the detected line superimposed on the original image
% subplot(1,2,2)
% imagesc(mag);
% colormap(gray);
% hold on;
% 
% for i = 1:size(c,2)
%     th = theta_range(c(i));
%     rh = rho_range(r(i));
%     m = -(cosd(th)/sind(th));
%     b = rh/sind(th);
%     x = 1:cols;
%     plot(x, m*x+b);
%     hold on;
% end

end