function im = scaling(im)
%% scaling the values of the image in the range of 0-255 by calculating the maximum and minimum values in the image matrix overall and then normalizing it
minimum = min(min(im));
maximum = max(max(im));
im = (im - minimum)./(maximum - minimum).*255;
end
