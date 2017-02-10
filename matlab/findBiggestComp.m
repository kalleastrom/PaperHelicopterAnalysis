function idxList = findBiggestComp(BW)
%Takes a binary image and returns the biggest component of that image. 

CC = bwconncomp(BW)

numPixels = cellfun(@numel, CC.PixelIdxList); %getting the areas
[biggest,idx] = max(numPixels); %finding the biggest object

idxList = CC.PixelIdxList{idx};

%bIm(idxList) = 0.5; %making the object gray. This is an
%example of how to access the component. 

end