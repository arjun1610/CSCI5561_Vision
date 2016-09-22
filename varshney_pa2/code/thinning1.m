function image = thinning1(image)
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

image=image.*255;
end

%% edge thinning iterator - Zhang Seun Algorithm
% implementation of cite- http://www-prima.inrialpes.fr/perso/Tran/Draft/gateway.cfm.pdf 
function thinImage = thinningIterator(thinImage, iteration)
marker=zeros(size(thinImage));
[len, bre]= size(thinImage);
for i=2: len-1
    for j=2: bre-1
        p2 = thinImage(i-1, j);
        p3 = thinImage(i-1, j+1);
        p4 = thinImage(i, j+1);
        p5 = thinImage(i+1, j+1);
        p6 = thinImage(i+1, j);
        p7 = thinImage(i+1, j-1);
        p8 = thinImage(i, j-1);
        p9 = thinImage(i-1, j-1);
        
        % checking how many 01 patterns are present in the neighborhood        
        A = (p2 == 0 && p3 == 1) + (p3 == 0 && p4 == 1) + (p4 == 0 && p5 == 1) + (p5 == 0 && p6 == 1) + (p6 == 0 && p7 == 1) + (p7 == 0 && p8 == 1) + (p8 == 0 && p9 == 1) + (p9 == 0 && p2 == 1);            
        B = p2 + p3 + p4 + p5 + p6 + p7 + p8 + p9;     
        
        if(iteration == 0)
            c1=p2*p4*p6;
            c2=p4*p6*p8;
        else 
            c1=p2*p4*p8;
            c2=p2*p6*p8;
        end
        % conditions to delete a pixel % guo hall Algo
        if (A == 1 && (B >= 2 && B <= 6) && c1 == 0 && c2 == 0)
                marker(i,j) = 1;
        end
    end    
end
thinImage = thinImage .* ~marker;
end