function output = part2(bin_image)
global pixel_queue labeled curlabValue;
% Start from the first pixel in the image. Set "curlab" (short for "current label") to 1. 
% Go to (2).
curlabValue=1;
[rows, cols]=size(bin_image);
labeled=zeros(rows,cols);
pixel_queue=[];
% flag= 0;
for i= 2:rows-1
    for j= 2:cols-1
        flag = 0;
        % 2) If this pixel is a foreground pixel and it is not already 
        % labeled, then give it the label "curlab" and add it as the first
        % element in a queue
        if bin_image(i,j) && labeled(i,j)== 0
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
        while ~isempty(pixel_queue)
            coordinates = pixel_queue(end,:);
            % popping out the last value;
            pixel_queue(end,:) = [];
            % find neighbors 
            doSomething(coordinates(1), coordinates(2), bin_image);
            flag = 1;
        end
        %Go to (2) for the next pixel in the image and increment "curlab" by 1.
        if flag==1 
            curlabValue = curlabValue+1;
        end
    end
end
output = labeled;

function doSomething(x, y, bin_image)
    % If a neighbour is a foreground pixel and is not already labeled, 
    % give it the "curlab" label and add it to the queue. 
    if bin_image(x-1, y-1)  && labeled(x-1, y-1)==0
        labeled(x-1, y-1) = curlabValue;
        pixel_queue = [pixel_queue; x-1 y-1];
    end
    if bin_image(x-1, y)  && labeled(x-1, y)==0
        labeled(x-1, y) = curlabValue;
        pixel_queue = [pixel_queue; x-1 y];
    end
    if bin_image(x-1, y+1)  && labeled(x-1, y+1)==0
        labeled(x-1, y+1) = curlabValue;
        pixel_queue = [pixel_queue; x-1 y+1];
    end
    if bin_image(x, y+1)  && labeled(x, y+1)==0
        labeled(x, y+1) = curlabValue;
        pixel_queue = [pixel_queue; x y+1];
    end
    if bin_image(x+1, y+1)  && labeled(x+1, y+1)==0
        labeled(x+1, y+1) = curlabValue;
        pixel_queue = [pixel_queue; x+1 y+1];
    end
    if bin_image(x+1, y)  && labeled(x+1, y)==0
        labeled(x+1, y) = curlabValue;
        pixel_queue = [pixel_queue; x+1 y];
    end
    if bin_image(x+1, y-1)  && labeled(x+1, y-1)==0
        labeled(x+1, y-1) = curlabValue;
        pixel_queue = [pixel_queue; x+1 y-1];
    end
    if bin_image(x, y-1)  && labeled(x, y-1)==0
        labeled(x, y-1) = curlabValue;
        pixel_queue = [pixel_queue; x y-1];
    end   
end

end