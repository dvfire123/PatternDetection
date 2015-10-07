function file = saveUserData(fig, folder)
    %Saves the user input data into a file in the specified folder
    lnHandle = findobj(fig, 'Tag', 'lastName');
    fnHandle = findobj(fig, 'Tag', 'firstName');
    wsHandle = findobj(fig, 'Tag', 'wspace');
    probHandle = findobj(fig, 'Tag', 'p');
    dimHandle = findobj(fig, 'Tag', 'sDim');
    nsHandle = findobj(fig, 'Tag', 'Ns');
    dtHandle = findobj(fig, 'Tag', 'dispTime');
    wtHandle = findobj(fig, 'Tag', 'waitTime');
    
    ln = get(lnHandle, 'String');
    fn = get(fnHandle, 'String');
    
    fileName = sprintf('%s-%s.din', fn, ln);
    fulFolder = folder;
    
    %Create and Save the file
    file = fullfile(fulFolder, fileName);
    fid = fopen(file, 'wt+');
    
    %Write to the file
    fprintf(fid, '%s\n', fn);
    fprintf(fid, '%s\n', ln);
    
    ws = get(wsHandle, 'String');
    prob = get(probHandle, 'String');
    sDim = get(dimHandle, 'String');
    Ns = get(nsHandle, 'String');
    dt = get(dtHandle, 'String');
    wt = get(wtHandle, 'String');
    
    fprintf(fid, '%s\n', ws);
    fprintf(fid, '%s\n', prob);
    fprintf(fid, '%s\n', sDim);
    fprintf(fid, '%s\n', Ns);
    fprintf(fid, '%s\n', dt);
    fprintf(fid, '%s\n', wt);
    
    fclose(fid);
end