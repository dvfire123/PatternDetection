function pix = getPix(coord)
    %Given the coordinate, get the pixel
    %where the resolution is 10x8, and 
    %both x and y axis has limits of 0 to 1
    
    x = coord(1);
    y = coord(2);
    
    xpix = max(1, min(ceil(x*10), 10));
    ypix = max(1, min(ceil(y*10), 10));
    
    pix = [ypix xpix];
end