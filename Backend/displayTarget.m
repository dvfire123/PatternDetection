function imageHandle = displayTarget(targ, axesHandle)
    %Given the target matrix, display the target

    alpha = ~targ;   %creates the alpha matrix for transparency
    imageHandle = image([0 1], [0 1], targ, 'Parent', axesHandle);
    set(imageHandle, 'AlphaData', alpha);
    colormap('gray');
    axis equal;
end