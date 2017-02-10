function [m2, m1] = newSecondMoment(img)


s = size(img);
xx = ones(s(1),1)*(1:s(2));
yy = ones(s(2),1)*(1:s(1));

m1 = zeros(2,1);
m1(1,1) = sum(sum(xx.*img))/sum(sum(img));
m1(2,1) = sum(sum(yy'.*img))/sum(sum(img));

m2 = zeros(2,2);
m2(1,1) = sum(sum((xx-m1(1,1)).^2.*img));
m2(1,2) = sum(sum((xx-m1(1,1)).*(yy'-m1(2,1)).*img));
m2(2,1) = m2(1,2);
m2(2,2) = sum(sum((yy'-m1(2,1)).^2.*img));
end