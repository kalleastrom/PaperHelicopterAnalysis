%%

addpath ../data

%mov = aviread('../data/data1.mov');


vidObj = VideoReader('../data/data1.mov');

% Specify that reading should start at 0.5 seconds from the
% beginning.
vidObj.CurrentTime = 0.5;

% Create an axes
figure(1); clf;
currAxes = axes;
kk = 0;
% Read video frames until available
vs=zeros(2,10);
while hasFrame(vidObj)
    kk = kk+1;
    imc = readFrame(vidObj);
    im = rgb2gray(imc);
    
    im = double(im)/256;
    
    
    %% Threshold
    imt = (im>0.7);
    %imt = (im>0.8);
    
    %%
    %figure(2);
    %imagesc(imt);
    
    %%
    tmp = bwlabel(imt);
    
    %% Keep only the largest segment;
    siz = zeros(1,max(tmp(:)));
    if max(tmp(:))>1,
        %disp('Keep only largest segment');
        for k = 1:max(tmp(:));
            siz(k)=sum(sum(tmp==k));
        end
    end
    [maxv,maxi]=max(siz);
    
    imm = tmp==maxi;
    %
    %figure(3);
    %imagesc(imm);
    
    %%
    [m,n]=size(imm);
    [xx,yy]=meshgrid(1:n,1:m);
    ee = ones(size(xx));
    m0 = sum(sum( ee.*imm ));
    m1 = [sum(sum( xx.*imm )); sum(sum( yy.*imm ))];
    cc = m1/m0;
    xxc = xx-cc(1);
    yyc = yy-cc(2);
    m2 = [sum(sum( ((xxc.^2).*imm ))) sum(sum( (xxc.*yyc).*imm ));sum(sum( (xxc.*yyc).*imm )) sum(sum( (yyc.*yyc).*imm ))];
    [vv,dd]=eig(m2);
    [maxv,maxi]=max(diag(dd));
    
    vs(:,kk) = vv(:,maxi);
    ms(:,kk) = cc;
    stats(kk) = regionprops(imm);
    
    
    
    
    
    
    figure(1);
    clf;
    colormap(gray);
    imagesc(imm);
    title(num2str(kk));
    pause(0.1);
end


as = atan2(vs(2,:),vs(1,:))
figure
plot(normangle2(as),'.')

tmp = normangle2(as);
dtmp = normangle2(diff(tmp));

figure;
clf;
subplot(2,1,1);
plot(tmp,'.');
subplot(2,1,2);
plot(dtmp,'.');

% 
% %%
% imc = readFrame(vidObj);
% im = rgb2gray(imc);
% im = double(im)/256;
% 
% %%
% figure(1);
% clf;
% imagesc(im);
% 
% %%
% imt = (im>0.5);
% 
% %%
% figure(2);
% imagesc(imt);
% 
% imt = (im>0.8);
% 
% %%
% figure(2);
% imagesc(imt);
% 
% %%
% tmp = bwlabel(imt);
% 
% %% Keep only the largest segment;
% if max(tmp(:))>1,
%     disp('Keep only largest segment');
% end
% 
% imm = tmp==1;
% 
% 
% figure(3);
% imagesc(imm);
% 
% %%
% [m,n]=size(imm);
% [xx,yy]=meshgrid(1:n,1:m);
% ee = ones(size(xx));
% 
% m0 = sum(sum( ee.*imm ));
% m1 = [sum(sum( xx.*imm )); sum(sum( yy.*imm ))];
% cc = m1/m0;
% xxc = xx-cc(1);
% yyc = yy-cc(2);
% m2 = [sum(sum( ((xxc.^2).*imm ))) sum(sum( (xxc.*yyc).*imm ));sum(sum( (xxc.*yyc).*imm )) sum(sum( (yyc.*yyc).*imm ))];
% 
% [dd,vv]=eig(m2);
% 
% stats = regionprops(imm)
% 
% 
% %%
% 
% 
% % Read video frames until available
% while hasFrame(vidObj)
%     vidFrame = readFrame(vidObj);
%     im = rgb2gray(im);
%     
%     image(vidFrame, 'Parent', currAxes);
%     currAxes.Visible = 'off';
%     pause(1/vidObj.FrameRate);
% end
% 
