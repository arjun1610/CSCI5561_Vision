function output = part2(bin_image)
global pixel_queue labeled curlabValue;
%L = bwlabel(bin_image);
% Start from the first pixel in the image. Set "curlab" (short for "current label") to 1. 
% Go to (2).
curlabValue=1;
[rows, cols]=size(bin_image);
labeled=zeros(rows,cols);
pixel_queue=[];

for i=1:rows
    for j=1:cols
        % 2) If this pixel is a foreground pixel and it is not already 
        % labelled, then give it the label "curlab" and add it as the first
        % element in a queue
        if bin_image(i,j) && labeled(i,j)~= curlabValue
            labeled(i,j)= curlabValue;
            pixel_queue= [pixel_queue ; i j];
        % If it is a background pixel, then repeat (2) for the next pixel 
        % in the image.    
        else
            if ~bin_image(i,j)
                continue;
            end
        end
        % 3) Pop out an element from the queue, and look at its neighbours 
        % (based on any type of connectivity). If a neighbour is a 
        % foreground pixel and is not already labeled, give it the 
        % "curlab" label and add it to the queue. Repeat (3) until there 
        % are no more elements in the queue.
        while(~isempty(pixel_queue))
            coordinates = pixel_queue(end,:);
            % popping out the last value;
            pixel_queue(end,:) = [];
            % find neighbors 
            doSomething(coordinates(1), coordinates(2), bin_image);
        end
        curlabValue= curlabValue+1 ;
    end
end
output = labeled;

function doSomething(i, j, bin_image)
    
    if bin_image(i-1, j-1)  && ~labeled(i-1, j-1)==curlabValue
        labeled(i-1, j-1) = curlabValue;
        pixel_queue = [pixel_queue; i-1 j-1];
    end
    if bin_image(i-1, j)  && ~labeled(i-1, j)==curlabValue
        labeled(i-1, j) = curlabValue;
        pixel_queue = [pixel_queue; i-1 j];
    end
    if bin_image(i-1, j+1)  && ~labeled(i-1, j+1)==curlabValue
        labeled(i-1, j+1) = curlabValue;
        pixel_queue = [pixel_queue; i-1 j+1];
    end
    if bin_image(i, j+1)  && ~labeled(i, j+1)==curlabValue
        labeled(i, j+1) = curlabValue;
        pixel_queue = [pixel_queue; i j+1];
    end
    if bin_image(i+1, j+1)  && ~labeled(i+1, j+1)==curlabValue
        labeled(i+1, j+1) = curlabValue;
        pixel_queue = [pixel_queue; i+1 j+1];
    end
    if bin_image(i+1, j)  && ~labeled(i+1, j)==curlabValue
        labeled(i+1, j) = curlabValue;
        pixel_queue = [pixel_queue; i+1 j];
    end
    if bin_image(i+1, j-1)  && ~labeled(i+1, j-1)==curlabValue
        labeled(i+1, j-1) = curlabValue;
        pixel_queue = [pixel_queue; i+1 j-1];
    end
    if bin_image(i, j-1)  && ~labeled(i, j-1)==curlabValue
        labeled(i, j-1) = curlabValue;
        pixel_queue = [pixel_queue; i j-1];
    end   
end

end