function [H, c] = secondMoment(img) 

%centre of mass
m1=zeros(2,1);
s = size(img);
for i=1:s(1)
    for j=1:s(2)
    m1 = m1 +[j;i]*img(i,j);
    end
end
m0 = sum(sum(img));
c = m1/m0;

%Second moment
A= zeros(2,2)
for i=1:s(1)
    for j=1:s(2)
    A = A + [(j-c(1))^2 (i-c(2))*(j-c(1)); (i-c(2))*(j-c(1)) (i-c(2))^2] * img(i,j);
    end
end
H = A
end
