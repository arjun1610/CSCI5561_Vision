function [ B ] = part3(img)
%PART3 Summary of this function goes here
%   Detailed explanation goes here
% img = zeros(70, 70);
% img(30:50, 30:50)=1;

% figure;
% imshow(img);

[row,col]=size(img);

B =[];
flag=0;
% find the first ROI pixel
for i = row -1 : -1: 2
    for j = 2 : col -1
        if img(i,j)
            s = [i j];
            B = [B; s];
            % this is probably wrong
            backtrack = [i j-1];
            flag =1;
            break;
        end
    end
    if flag==1
        break;
    end
end

% Moore is a 8 x 2 matrix (x,y)
Moore = neighborhood(s(1), s(2), backtrack);
neighborhood_sum=0;

for i= 1: length(Moore)
     neighborhood_sum =neighborhood_sum + img(Moore(i,1), Moore(i,2));
end

if neighborhood_sum==0
    return;
end
% this is the next clockwise pixel after backtracking
c = Moore(1,:);
while ~isequal(c,s)
    if img(c(1), c(2)) % isempty(find(ismember(B, c, 'rows'),1))
        B = [B; c];
        Moore = neighborhood(c(1), c(2), Moore(end,:)); 
        c = Moore(1,:);                
    else
        Moore = circshift(Moore, [-1 2]);
        c = Moore(1,:);                                
    end
end

% val = zeros(row,col);
% for i= 1: length(B)
%     val(B(i,1),B(i,2))=1;
% end
% figure;
% imshow(val);


function M_coordinates = neighborhood(x,y, backtrack_coordinates)    
    % we march towards south and then west and then north and then east. 
    % M_coordinates_value stores the coordinates values
    M_coordinates= [x+1 y; x+1 y-1 ; x y-1 ; x-1 y-1 ; x-1 y ; x-1 y+1 ; x y+1 ; x+1 y+1 ];    
    shift_ind=find(ismember(M_coordinates, backtrack_coordinates, 'rows'));
    M_coordinates=circshift(M_coordinates,[1-shift_ind, 2]);    
end
end
