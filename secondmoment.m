%%  
function [H, c] = secondmoment(img)
% calculate the centre of mass by zeroth and first moment m0 and m1
%img = [1 2;3 4]

m0 = sum(sum(img)); % zeroth moment m0
s = size(img) 

m1 = zeros(2,1);
for i = 1:s(2) 
    for j = 1:s(1)
        m1 = m1 + [i j]'*img(i, j); % first moment m1
    end
end

%s(1) antal rader y-led
%s(2) antal kolonner x-led

c = m1/m0

m2 = zeros(2,2);
for i=1:s(1)
    for j=1:s(2)
        m2 = m2 + [(j-c(1))^2 (j-c(1))*(i-c(2));(j-c(1))*(i-c(2)) (i-c(2))^2]*img(i, j);
    end
end

H = m2;
c = c
end
 