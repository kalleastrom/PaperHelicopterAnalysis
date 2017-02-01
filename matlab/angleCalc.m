function [a,c,direction] = angleCalc(im)
%Takes a grayscale image and returns the angle of the eigen vector
%corresponding to the largest eigen value to the second moment matrix.
%im = imread('..\data\testBild.jpg');
% im = rgb2gray(im);
%cropIm = im(100:500,1:405);
%bIm = cropIm>100;
%imagesc(bIm)
%colormap(gray)
%hold on
img = im2double(im);
[H,c] = secondMoment(img);
[V E] = eig(H);
[vals ind] = max(max(E));
ev = V(:,ind);
angle = atan(ev(2)/ev(1));
a=normangle2(angle);
direction = ev;
%grads = angle *180/pi

% p1 = c
% p2 = c + ev*100
% p3 = c + ev*(-100)
% plot(p1(1),p1(2), '*r')
% line([p1(1) p2(1)], [p1(2) p2(2)])
% line([p1(1) p3(1)], [p1(2) p3(2)])

end
