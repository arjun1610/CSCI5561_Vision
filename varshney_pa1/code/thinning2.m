function image = thinning2(image)
% image=zeros(128,128);
% for i=1:126
%     image(i,i:i+6)=255;
% end
% 

image=image./255;
previous=zeros(size(image));
flag=1;
while(flag)
    image=thinningIterator(image,0);
    image=thinningIterator(image,1);
    diff=abs(image-previous);
    previous=image;
    if(isempty(find(diff,1)))
        flag=0;
    end
end

image = image .* 255;
end

%% edge thinning iterator - Guo Hall algorithm
% implementation of cite- dl.acm.org/citation.cfm?id=62074
function thinImage = thinningIterator(thinImage, iteration)
marker=zeros(size(thinImage));
[len, bre]= size(thinImage);
for i=2: len-1
    for j=2: bre-1
        % 8 connectivity neighborhood
        p2 = thinImage(i-1, j);
        p3 = thinImage(i-1, j+1);
        p4 = thinImage(i, j+1);
        p5 = thinImage(i+1, j+1);
        p6 = thinImage(i+1, j);
        p7 = thinImage(i+1, j-1);
        p8 = thinImage(i, j-1);
        p1 = thinImage(i-1, j-1);
        % checking how many 01 patterns are present in the neighborhood
        C = (~p2 && (p3 || p4)) + (~p4 && (p5 || p6)) +(~p6 && (p7 || p8)) +(~p8 && (p1 || p2));
        % checking how many neighbors are actually present as edge pixels
        N1 = (p1 || p2) + (p3 || p4) + (p5 || p6) + (p7 || p8);
        N2 = (p2 || p3) + (p4 || p5) + (p6 || p7) + (p8 || p1);
        N = min(N1, N2);
        
        if(iteration == 0)
            direction= (p2 || p3 || ~p5) && p4;
        else
            direction= (p6 || p7 || ~p1) && p8;
        end
        % conditions to delete a pixel % guo hall Algo
        if (C == 1 && (N >= 2 && N <= 3) && direction == 0)
                marker(i,j) = 1;
        end
    end    
end
thinImage = thinImage .* ~marker;
end