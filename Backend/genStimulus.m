function isInTarget = genStimulus(p, height, width, percentWhite, target, axesHandle)
%Generates the dot pattern given percent white
%p: probability that the target will be included in the stimulus or not
%Returns whether or not the target is in the stimulus
    dotPat = createDotPattern(height, width, percentWhite);
    stim = dotPat;
    isInTarget = 0;
    rand('twister', 100*sum(clock));
    
    if rand <= p
       %target to be included in the stimulus
       isInTarget = 1;
       newTar = trimTarget(target);
       %randomly insert newTar into tar
       [xt, yt] = size(newTar);
       availHeight = height - xt;
       availWidth = width - yt;
       
       xinsert = ceil(availHeight*rand);
       yinsert = ceil(availWidth*rand);
       
       stim(xinsert:xinsert+xt-1, yinsert:yinsert+yt-1) = newTar;
    end    
    
    xl = [1/(2*width), 1 - 1/(2*width)];
    yl = [1/(2*height), 1 - 1/(2*height)];
    
    imagesc(xl, yl, stim, 'parent', axesHandle);
    colormap('gray');
    axis equal;
end

