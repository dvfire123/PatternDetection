function updateUserData(Inputs, folder)
    %Updates the user data based on the new data
    %inputs cell array Inputs and save into the folder
    
    ln = Inputs{2};
    fn = Inputs{1};
    sDim = Inputs{5};
    prob = Inputs{4};
    ws = Inputs{3};
    Ns = Inputs{6};
    dt = Inputs{7};
    wt = Inputs{8};
    
    fileName = sprintf('%s-%s.din', fn, ln);
    fulFolder = folder;
    
    %Create and Save the file
    file = fullfile(fulFolder, fileName);
    fid = fopen(file, 'wt+');
    
    %Write to the file
    fprintf(fid, '%s\n', fn);
    fprintf(fid, '%s\n', ln);
    fprintf(fid, '%s\n', ws);
    fprintf(fid, '%s\n', prob);
    fprintf(fid, '%s\n', sDim);
    fprintf(fid, '%s\n', Ns);
    fprintf(fid, '%s\n', dt);
    fprintf(fid, '%s\n', wt);
    
    fclose(fid);
end