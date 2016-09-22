function image_Exp= expansion(image_Exp)
[a,b] = size(image_Exp);
flag_ex=zeros(a,b);
for i= 2 : a-1
    for j= 2 : b-1
        if (image_Exp(i,j)==1)
            flag_ex(i-1, j)=1;
            flag_ex(i-1, j+1)=1;
            flag_ex(i, j+1)=1;
            flag_ex(i+1, j+1)=1;
            flag_ex(i+1, j)=1;
            flag_ex(i+1, j-1)=1;
            flag_ex(i, j-1)=1;
            flag_ex(i-1, j-1)=1;
        end
    end    
end
image_Exp = image_Exp | flag_ex;
image_Exp = image_Exp .* 255;
end
            