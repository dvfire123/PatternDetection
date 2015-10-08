function dotPat = createDotPattern(height, width, percentWhite)
    %Creates the random dot pattern
    dotPattern = zeros(height, width);

    dotPattern(1:round(0.01*percentWhite*numel(dotPattern))) = 1;
    rand('twister', 100*sum(clock));

    dotPat = reshape(dotPattern(randperm(numel(dotPattern))), height, width);
end