function [ flag, thinImage_west ] = thinning3( thinImage)

[m,n] = size(thinImage);
flag = 0;
[flag_north, thinImage_north] = dir_thinning(thinImage,0);
[flag_south, thinImage_south] = dir_thinning(thinImage_north,1);
[flag_east, thinImage_east] = dir_thinning(thinImage_south,2);
[flag_west, thinImage_west] = dir_thinning(thinImage_east,3);
flag = flag_north+flag_south+flag_east+flag_west;
end

function [flag, thinImage_new] = dir_thinning(thinImage, dir)

[m,n] = size(thinImage);
flag = 0;
thinImage_new = zeros(m,n);
count = 0;
w = 0;
x = 0;
y = 0;
z = 0;
if(dir == 0)
    w = m-1;
    x = 2;
    y = 2;
    z = n-1;
else if(dir == 3)
        w = 2;
        x = m-1;
        y = n-1;
        z = 2;
    else
        w = 2;
        x = m-1;
        y = 2;
        z = n-1;
    end
end
if((dir == 0) | (dir == 1))
    for(j=y:z)
        for(i=w:-1+(2*dir):x)
            if(thinImage(i,j) == 1)
                count = count_neighbors(thinImage,i,j);
                tmp = 0;
                if((count == 1) | (count == 0))
                    thinImage_new(i,j) = 1;
                    tmp = 1;
                end
                if(count >= 2)
                    template_match = template(thinImage,i,j);
                    if(template_match == 1)
                        thinImage_new(i,j) = 1;
                        tmp = 1;
                    end
                end
                if(thinImage(i-1+(2*dir),j) == 1)
                    thinImage_new(i,j) = 1;
                    tmp = 1;
                end
                if (tmp ~= 1)
                    flag = flag+1;
                end
            end
        end
    end
end
if((dir == 2) | (dir == 3))
    for(i=w:x)
        for(j=y:1+(2*(2-dir)):z)
            if(thinImage(i,j) == 1)
                count = count_neighbors(thinImage,i,j);
                tmp = 0;
                if((count == 1) | (count == 0))
                    thinImage_new(i,j) = 1;
                    tmp = 1;
                end
                if(count >= 2)
                    template_match = template(thinImage,i,j);
                    if(template_match == 1)
                        thinImage_new(i,j) = 1;
                        tmp = 1;
                    end
                end
                if(thinImage(i,j+1-(2*(dir-2))) == 1)
                    thinImage_new(i,j) = 1;
                    tmp = 1;
                end
                if(tmp ~= 1)
                    flag = flag + 1;
                end
            end
        end
    end
end
end

function B = count_neighbors (thinImage, i, j)
        
        p2 = thinImage(i-1, j);
        p3 = thinImage(i-1, j+1);
        p4 = thinImage(i, j+1);
        p5 = thinImage(i+1, j+1);
        p6 = thinImage(i+1, j);
        p7 = thinImage(i+1, j-1);
        p8 = thinImage(i, j-1);
        p9 = thinImage(i-1, j-1);
        B = p2 + p3 + p4 + p5 + p6 + p7 + p8 + p9;     
end

function [template_match] = template(thinImage,i,j)
    template_match = 0;
    if((thinImage(i,j-1) == 1) & (thinImage(i,j+1) == 1) & (thinImage(i-1,j) == 0) & (thinImage(i+1,j) == 0))
        template_match = 1;
    end
    if((thinImage(i,j-1) == 0) & (thinImage(i,j+1) == 0) & (thinImage(i-1,j) == 1) & (thinImage(i+1,j) == 1))
        template_match = 1;
    end
    if((thinImage(i,j-1) == 0) & (thinImage(i+1,j) == 0) & (thinImage(i+1,j-1) == 1))
        template_match = 1;
    end
    if((thinImage(i-1,j) == 0) & (thinImage(i,j+1) == 0) & (thinImage(i-1,j+1) == 1))
        template_match = 1;
    end
    if((thinImage(i+1,j) == 0) & (thinImage(i,j+1) == 0) & (thinImage(i+1,j+1) == 1))
        template_match = 1;
    end
    if((thinImage(i,j-1) == 0) & (thinImage(i-1,j) == 0) & (thinImage(i-1,j-1) == 1))
        template_match = 1;
    end
end