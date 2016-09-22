function ellipse = hough_transform_ellipse( img )
%% Function to detect ellipses using Hough Transform 
% reference paper used to implement - "A NEW EFFICIENT ELLIPSE DETECTION METHOD" 
% http://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=1048464

% worth mentioning 
% 1412 (79.3%), 1658 (93.1%), 1773(99.6) 
% Recall (TP/(Actual Positives) Percentage as we increase the eps from 0.05 to 0.1 to 0.15
% Precision Percentages
% 30.53, 18.04% ,13.18%
% F score -     0.4406    0.3017    0.2315
[rows, cols] = size( img );
edges_count = size( find( img( 2:end-1, 2:end-1 ) == 255), 1 );
edge_coordinates = find_edges( img );
min_a = 10;
min_votes = 120;
% should be half the length of the diagonal of the image
max_b = round(sqrt( rows^2 + cols^2)/2);
ellipse = [];
detect_ellipse = zeros(rows, cols);

for i = 1: edges_count
%     for j = edges_count: -1: i+1
    for j = i+1 : edges_count
        % find two pairs for which will serve as end points (2a)
        % treat x as y and y as x in the whole code, because in the
        % coordinate system we treat x as columns and y as rows as per 
        % arrays coordinates
        % two points can't be same
        if(i == j)
            continue;
        end
        x1 = edge_coordinates(i, 1);
        y1 = edge_coordinates(i, 2);
        
        x2 = edge_coordinates(j, 1);
        y2 = edge_coordinates(j, 2);
        % this condition is put to accomodate deleted edge pixels from
        % edges array
        if x1 > 0 && y1 > 0 && x2 > 0 && y2 > 0 
            dist = distance(x1, y1, x2, y2);
            if dist >= 2 * min_a 
                x0 = ((x1 + x2)/2);
                y0 = ((y1 + y2)/2);
                a = dist/2;
                alpha = atan2( (x2 - x1), (y2 - y1) );
                acc = zeros(max_b,1);
                % this condition is used to eliminate ellipses which are
                % not parallel to x-axis, due to the image given, i am
                % using this condition alpha = 0 means the ellipses would
                % be parallel to x-axis
                if alpha~=0
                    continue;
                end
                % TODO - use matrix here if time permits
                for k = 1: edges_count
                    % eliminating any similar points taken above
                    if(k == i || k == j)
                        continue;
                    end
                    x = edge_coordinates(k, 1);
                    y = edge_coordinates(k, 2);
                    dist1 = distance(x0, y0, x, y);
                    if dist1 >= a
                        continue;
                    end
                    f1 = distance(x, y, x1, y1);
                    cos_tau = ( a^2 + dist1^2 - f1^2 )/(  2 * a * dist1 );
                    b = sqrt( abs( a^2 * dist1^2 * ( 1- cos_tau^2 )/( a^2 - dist1^2 * cos_tau^2 )));
                    b = ceil( b );
                    % ignore large b values
                    if b > 0 && b <= max_b
                        acc(b) = acc(b) + 1;
                    end 
                end
                [value, index] = max( acc );
                if value >= min_votes
                    % ellipse detected, store the values for ellipse
                    ellipse = [ellipse; x0 y0 a index alpha value];
                end
            end
        end
    end
    % find the best fit ellipse for a given first point (x1,y1)
    if( ~isempty(ellipse) )
        [~, ind] = max(ellipse(:, 6));
        b_x0 = ellipse(ind,1);
        b_y0 = ellipse(ind,2);
        b_a = ellipse(ind,3);
        b_b = ellipse(ind,4);
        % not being used
        % b_alpha = ellipse(ind,5);
        display(ellipse(ind,:));
        [edge_coordinates, img, detect_ellipse] = make_ellipse_remove_edge_pixels( edge_coordinates, b_x0, b_y0, b_a, b_b, img, detect_ellipse );              
        ellipse = [];
    end
end

% final superimposed image
f1=figure('name', 'SuperImposed Figure on ');
super_impose = imfuse(detect_ellipse, img);
imshow( super_impose);
saveas(f1, 'ellipse_houghTransform_superImposed.jpg');

% TP=size(find(edge_coordinates(:,1)==0),1);
% TP_FP=size(find_edges( detect_ellipse.*255),1);
% display(TP/TP_FP*100);
end

function d = distance(x1, y1, x2, y2)
% standard distance formula
    d = sqrt( ( x1 - x2)^2 + ( y1 - y2)^2);
end

function coordinates = find_edges( img )
% find edge pixels
[x, y] = find( img( 2: end-1, 2: end-1) == 255 );
coordinates = [x y];
end

function [edge_coordinates, img, ellipses] = make_ellipse_remove_edge_pixels(edge_coordinates, x0,y0,a,b,img, ellipses)
%% function to make ellipse and remove the relevant edge pixels
[rows, cols] = size(img);
% create possible best fit ellipse from the parameters
% we give a range (0.95 to 1.05) for ellipse formation to detect approximate ellipse
% pixels
eps = 0.05;
val = zeros( rows, cols );
for i = 1: rows
    for j = 1: cols
        val(i,j) =(j-y0)^2/a^2 + (i-x0)^2/b^2 ;
        val(i,j) = val(i,j) >= 1-eps && val(i,j) <= 1+eps;

    end
end

% remove edge pixels which have already been detected
[x, y] = find( val == 1 );
coordinates = [x y];
for i = 1: length(coordinates)
    for j= 1: length(edge_coordinates)
        if coordinates(i, 1) == edge_coordinates(j, 1) && coordinates(i, 2) == edge_coordinates(j, 2)
            edge_coordinates(j, :) = 0;
        end
    end
end

% create image with cumulative ellipses
f2=figure('name', 'Detected Ellipses');
ellipses = val + ellipses;
imshow(ellipses);
saveas(f2, 'ellipses_detected.jpg');
end