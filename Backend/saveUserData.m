function file = saveUserData(fig, folder)
    %Saves the user input data into a file in the specified folder
    lnHandle = findobj(fig, 'Tag', 'lastName');
    fnHandle = findobj(fig, 'Tag', 'firstName');
    wsHandle = findobj(fig, 'Tag', 'wspace');
    probHandle = findobj(fig, 'Tag', 'p');
    dimHandle = findobj(fig, 'Tag', 'sDim');
    
    ln = get(lnHandle, 'String');
    fn = get(fnHandle, 'String');
    
    fileName = sprintf('%s-%s.din', fn, ln);
    fulFolder = fullfile(pwd, folder);
    
    %Create and Save the file
    file = fullfile(fulFolder, fileName);
    fid = fopen(file, 'wt');
    
    %Write to the file
    fprintf(fid, '%s', fn);
    fprintf(fid, '%s', ln);
    
    ws = get(wsHandle, 'String');
    prob = get(probHandle, 'String');
    sDim = get(dimHandle, 'String');
    
    fprintf(fid, '%d', ws);
    fprintf(fid, '%f', prob);
    fprintf(fid, '%d', sDim);
    
    close(gcf);
end