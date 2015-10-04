function stimHandle = genStimulus(p, height, width, percentWhite, target, axesHandle)
%Generates the dot pattern given percent white
%p: probability that the target will be included in the stimulus or not
    dotPat = createDotPattern(height, width, percentWhite);
    stim = dotPat;
    if rand <= p
       %target to be included in the stimulus
       newTar = trimTarget(target);
       %randomly insert newTar into tar
       [xt, yt] = size(newTar);
       availHeight = height - xt;
       availWidth = width - yt;
       
       xinsert = ceil(availHeight*rand);
       yinsert = ceil(availWidth*rand);
       
       stim(xinsert:xinsert+xt-1, yinsert:yinsert+yt-1) = newTar;
    end    
    
    xl = get(axesHandle, 'XLim');
    yl = get(axesHandle, 'YLim');
    
    stimHandle = imagesc(xl, yl, stim, 'parent', axesHandle);
    colormap('gray');
    axis equal;
end

