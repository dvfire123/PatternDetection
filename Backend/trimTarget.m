function newTar = trimTarget(target)
    %Cuts all the excess white space
    %found on the target
    %newTar still rectangluar (smallest that can enclose
    %the old target)
    
    workTarget = ~target; %invert to work with 0s
    
    %Special case: blank target
    %just return original target
    if all(~any(workTarget))
        newTar = target;
        return;
    end
    
    [h, w] = size(workTarget);
    lc = 1;
    rc = w;
    lr = 1;
    ur = h;
    
    %left scan
    for j = 1:w
       if any(workTarget(:, j))
           lc = j;
           break;
       end
    end
    
    %right scan
    for j = w:-1:1
        if any(workTarget(:, j))
           rc = j;
           break;
       end
    end
    
    %lower scan
    for i = 1:h
       if any(workTarget(i, :))
           lr = i;
           break;
       end 
    end
    
    %upper scan
    for i = h:-1:1
       if any(workTarget(i, :))
           ur = i;
           break;
       end 
    end
    
    %Get the newTar
    newTar = target(lr:ur, lc:rc);
end