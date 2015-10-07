function bhandle = blankStimulus(height, width, axesHandle)
%Generates a blank stimulus
    stim = ones(height, width);
    
    xl = [1/(2*width), 1 - 1/(2*width)];
    yl = [1/(2*height), 1 - 1/(2*height)];
    
    bhandle = imagesc(xl, yl, stim, 'parent', axesHandle);
    colormap('gray');
    axis equal;
    close;
end

