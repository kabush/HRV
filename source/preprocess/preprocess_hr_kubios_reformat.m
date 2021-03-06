%%========================================
%%========================================
%%
%% Keith Bush, PhD (2018)
%% Univ. of Arkansas for Medical Sciences
%% Brain Imaging Research Center (BIRC)
%%
%%========================================
%%========================================

%% Load in path data
load('proj.mat');

%% Set-up Directory Structure
if(proj.flag.clean_build)
    disp(['Removing ',proj.path.physio.hr_kubios_reformat]);
    eval(['! rm -rf ',proj.path.physio.hr_kubios_reformat]);
    disp(['Creating ',proj.path.physio.hr_kubios_reformat]);
    eval(['! mkdir ',proj.path.physio.hr_kubios_reformat]);
end

subjs = load_subjs(proj);
disp(['Processing fMRI of ',num2str(numel(subjs)),' subjects']);

%% Preprocess fMRI of each subject in subjects list 
for i=1:numel(subjs)

    %% extract subject info
    subj_study = subjs{i}.study;
    name = subjs{i}.name;

    %% debug
    disp([subj_study,':',name]);

    try
        path_id_1 = [proj.path.physio.hr_kubios_output,subj_study, ...
                     '_',name,'_Identify_run_1_hr.mat'];
        load(path_id_1);

        rr = Res.HR.Data.T_RR;
        csvwrite([proj.path.physio.hr_kubios_reformat,subj_study, ...
                  '_',name,'_Identify_run_1_kubios_reformat.csv'],rr);
    catch
        disp('could not reformat Identify 1');
    end


    try
        path_id_2 = [proj.path.physio.hr_kubios_output,subj_study, ...
                     '_',name,'_Identify_run_2_hr.mat'];
        load(path_id_2);

        rr = Res.HR.Data.T_RR;
        csvwrite([proj.path.physio.hr_kubios_reformat,subj_study, ...
                  '_',name,'_Identify_run_2_kubios_reformat.csv'],rr);
    catch
        disp('could not reformat Identify 2');
    end

end
