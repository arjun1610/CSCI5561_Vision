function [ output_args ] = part3
%PART3 Summary of this function goes here
%   Detailed explanation goes here
im = zeros(100,100);
im(40:60, 50:70)=1;

figure;
imshow(im);

B =[];
for i = row-1 : -1: 2
    for j = 2 : col -1
        if im(i,j)
            s = [i j];
            B = [B;s];
            p = s ;
            
        end
            
    end
end

function M = neighborhood(x,y)    
    p1 = thinImage(x-1, y-1);
    p2 = thinImage(x-1, y);
    p3 = thinImage(x-1, y+1);
    p4 = thinImage(x, y+1);
    p5 = thinImage(x+1, y+1);
    p6 = thinImage(x+1, y);
    p7 = thinImage(x+1, y-1);
    p8 = thinImage(x, y-1);
    M = [p1 p2 p3 p4 p5 p6 p7 p8];    
end
end
