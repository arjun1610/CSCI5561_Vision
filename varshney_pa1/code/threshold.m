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
