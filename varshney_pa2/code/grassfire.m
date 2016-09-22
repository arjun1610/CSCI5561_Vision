function grassfire(filename, color)

image=imread(filename);

if(color)
   image=rgb2gray(image);
end
[rows, cols]= size(image);
image=double(image);
imshow(image);
img=image;
for i=2: rows-1
    for j=2: cols-1
        p2 = image(i-1, j+1); % diagonal right above 
        p3 = image(i-1, j); % just above
        p4 = image(i-1, j-1); % diagonal left above
        p5 = image(i, j-1); % just left
        if(image(i,j)==0)
            image(i, j)= 1+ min([p2,p3, p4,p5]);
        else
            image(i, j)= 0;
        end    
    end
end

for i=rows-1:-1:2
    for j=cols-1:-1:2
        p6 = image(i+1, j+1); % diagonal right below
        p7 = image(i+1, j); % just below
        p8 = image(i+1, j-1); % diagonal left below
        p9 = image(i, j+1); % just right        
        if(img(i,j)==0)
            image(i, j)= min(image(i,j), 1+ min([p6, p7,p8, p9]));
        else
            image(i, j)= 0;
        end    
    end
end

max1=max(max(image(2:rows-1, 2:cols-1)));
min1=min(min(image(2:rows-1, 2:cols-1)));
image = round((image(2:rows-1, 2:cols-1)-min1)./ (max1-min1).*255);
figure;
imshow(image, [0 255]);

end