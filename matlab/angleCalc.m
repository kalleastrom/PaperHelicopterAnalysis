function [a,c,direction] = angleCalc(im)
%Takes a grayscale image and returns the angle of the eigen vector
%corresponding to the largest eigen value to the second moment matrix.

img = im2double(im);
[H,c] = newSecondmoment(img);
[V E] = eig(H);
[vals ind] = max(max(E));
ev = V(:,ind);
angle = atan(ev(2)/ev(1));
a=angle;% a=normangle2(angle);
direction = ev;

end
