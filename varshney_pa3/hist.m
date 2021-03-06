function  hist( filename )

%HIST Summary of this function goes here
%   Detailed explanation goes here
close all;
image=imread(filename);
% figure;
% imshow(image);
% figure
% imhist(image);
% [row,col]=size(image);
image=double(image);

% % % %smoothing
% % % % val=zeros(row,col);
% % % % for i=2:row-1
% % % %     for j=2:col-1
% % % %         val(i,j)= image(i,j) + image(i-1,j)+ image(i+1,j);               
% % % %     end
% % % % end
% % % % minVal=min(min(val));
% % % % maxVal=max(max(val));
% % % % val=round((val-minVal)./(maxVal-minVal).*255);

val=image;
% figure
% imhist(uint8(val));

value = threshold(val);
val = (val <= value);

val=[zeros(size(val,1),1) val zeros(size(val,1),1)]; 
val=[zeros(size(val,2),1)'; val; zeros(size(val,2),1)']; 

figure;
imshow(val);

output = part2(val);
RGB_label =  label2rgb(output); 
figure;
imshow(RGB_label,'InitialMagnification','fit')

A = unique(output);

new_image = zeros(size(output,1),size(output,2));
border_pixels = [];
% create image
for i=2: length(A)
    [xc, yc]=find(output==A(i));
    for j =1 :size(xc,1)
        new_image(xc(j),yc(j))=1;
    end
    border_output=part3(new_image);
    border_pixels=[border_pixels; border_output];
    new_image = zeros(size(output,1),size(output,2));
end

fin_image = zeros(size(output,1),size(output,2));
for i= 1: length(border_pixels)
    fin_image(border_pixels(i,1),border_pixels(i,2))=1;
end

figure;
imshow(fin_image);

end

function value = threshold(P)
%% function to calculate the threshold value
% K-means clustering thresholding algorithm is used here
% where we repititively calculate the 'means' of two classes one above and
% one below that the mean. and do this until the means converge. 
% http://homepages.inf.ed.ac.uk/rbf/CVonline/LOCAL_COPIES/MORSE/threshold.pdf
% Section: 4.4.3
%%
epsilon=0.1;
P = P(:);
i=1;
Threshold(i)=mean(P);
Mean1= mean(P(P<Threshold(i)));
Mean2= mean(P(P>=Threshold(i)));
i=i+1;
Threshold(i)= (Mean1+Mean2)/2;
value=Threshold(i);
%change the epsilon value to get more/less pixels (noise issue)
while abs(Threshold(i)-Threshold(i-1))>=epsilon
    Mean1= mean(P(P<Threshold(i)));
    Mean2= mean(P(P>=Threshold(i)));
    i=i+1;
    Threshold(i)= (Mean1+Mean2)/2;
    value=Threshold(i);
end
end
