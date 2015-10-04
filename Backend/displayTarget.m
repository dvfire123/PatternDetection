function imageHandle = displayTarget(targ, axesHandle)
    %Given the target matrix, display the target
    
    xl = get(axesHandle, 'XLim');
    yl = get(axesHandle, 'YLim');

    imageHandle = imagesc(xl, yl, targ, 'Parent', axesHandle);
    colormap('gray');
    axis equal;
end