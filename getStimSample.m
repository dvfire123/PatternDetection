function getStimSample(height, width, percentWhite, target, axesHandle)
%Generates a sample of the stimulus with target at top left corner
%Generates the dot pattern given percent white
    dotPat = createDotPattern(height, width, percentWhite);
    stim = dotPat;
    rand('twister', 100*sum(clock));
    
    %target to be included in the stimulus at the top left corner
    newTar = trimTarget(target);
    [xt, yt] = size(newTar);
    stim(1:xt, 1:yt) = newTar;
    
    xl = [1/(2*width), 1 - 1/(2*width)];
    yl = [1/(2*height), 1 - 1/(2*height)];
    
    delete(get(axesHandle, 'Children'));
    imagesc(xl, yl, stim, 'parent', axesHandle);
    colormap('gray');
    axis equal;
end

