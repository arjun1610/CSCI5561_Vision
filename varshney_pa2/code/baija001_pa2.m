function baija001_pa2(file)
image = imread(file);

image=rgb2gray(image);
img=double(image);
img = Sobel(img);
imshow(img);

%Get the size of the Imageand the max line size possible
[r, c] = size(img);
maxB= sqrt( r^2 + c^2);

NumEll = 0;
ellipse=[];
detect=zeros(r,c);
% count the number of edge points
count = 0;
for a = 2:r-1
    for b = 2:c-1
        if img(a,b) ~=0
            count = count +1;
        end
    end
end


pixels = zeros(count, 2);
count1 = 1;
for a1 = 2:r-1
    for b1 = 2:c-1
        if img(a1,b1) ~=0
            pixels(count1, 1) = b1;
            pixels(count1, 2) = a1;
            count1 = count1 + 1;
        end
    end
end


leastDis = 10;       %edit!
minVotes = 120;

    for r1 = 1:count
        x1 = pixels(r1, 1);
        y1 = pixels(r1, 2);
        for r2 = 1:count
            if r2 ~= r1   %only for other points
                %calculate ditance
                x2 = pixels(r2, 1);
                %disp(x2);
                y2 = pixels(r2, 2);
                dis = sqrt((x2 - x1)^2 + (y2 - y1)^2);
                if dis > leastDis
                    %do steps 4-14
                    x0 = (x1+x2)/2;
                    y0 = (y1+y2)/2;
                    a = (sqrt((x2-x1)^2 + (y2-y1)^2))/2;
                    alpha = atan((y2-y1)/(x2-x1));
                    AH = zeros(count,1);      %the acc array for minor axis
                    if alpha == 0   %step 6 onwards only if ellipse has the correct orientation
                        for r3 = 1:count
                            if r3~=r2 || r3~=r1
                                x = pixels(r3, 1);
                                y = pixels(r3, 2);
                                dis0 = sqrt((x - x0)^2 + (y - y0)^2);
                                dis01 = sqrt((x0 - x1)^2 + (y0 - y1)^2); % same hai
                                dis02 = sqrt((x2 - x0)^2 + (y2 - y0)^2); % same hai
                                if (dis0 < dis01) || (dis0 < dis02)
                                    %calculate the minor axis
                                    dis2 = sqrt((x - x2)^2 + (y - y2)^2);
                                    dis1 = sqrt((x - x1)^2 + (y - y1)^2);
                                    cosT = (a^2 + dis0^2 - dis2^2) / (2*a*dis0);
                                    invCos = acos(cosT);
                                    sinT = sin(invCos);
                                    b = sqrt((a^2 *dis0^2 * sinT^2)/(a^2 - dis0^2 * cosT^2));
                                    bR = round(b);
                                    %increment the acc for this minor axis
                                    if(bR > 0 && bR< maxB)
                                        AH(bR) = AH(bR) + 1;
                                    end
                                end  
                            end
                        end
                        %end of third for loop
                        [MV, MI] = max(AH);
                        bMax = MI;
                        if MV > minVotes  %one ellipse detected, steps 11-14
                            %disp(bMax);
                            detect=draw_ellipse(x0, y0,a, bMax, alpha, detect);   
                            ellipse=[ellipse; x0, y0, a, bMax, alpha,MV ];

                            NumEll = NumEll + 1;
                        end
                    end
                end
            end
        end
    end
    
function d_ellipse=draw_ellipse(x0, y0, a, b, alpha, d_ellipse)
%% function to make ellipse and remove the relevant edge pixels
[rows, cols] = size(img);
% create possible best fit ellipse from the parameters
% we give a range (0.95 to 1.05) for ellipse formation to detect approximate ellipse
% pixels
eps = 0.05;
val = zeros( rows, cols );
for i = 1: rows
    for j = 1: cols
        val(i,j) =(j-x0)^2/a^2 + (i-y0)^2/b^2 ;
        val(i,j) = val(i,j) >= 1-eps && val(i,j) <= 1 + eps;
    end
end

% create image with cumulative ellipses
f2=figure('name', 'Detected Ellipses');
d_ellipse= val + d_ellipse;
imshow(d_ellipse);
% saveas(f2, 'ellipses_detected.jpg');
end        
    
    disp(NumEll);
end