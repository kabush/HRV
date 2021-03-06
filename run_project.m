%%========================================
%%========================================
%%
%% Keith Bush, PhD (2018)
%% Univ. of Arkansas for Medical Sciences
%% Brain Imaging Research Center (BIRC)
%%
%%========================================
%%========================================

%% ------------------------------------------------------------
%% Clean up matlab environment
matlab_reset; % debug

tic

%% ------------------------------------------------------------
%% Link all source code
addpath(genpath('./source/'));

%% ------------------------------------------------------------
%% STEP 1: Initialize the projects directories and parameters.
init_project;

%% ------------------------------------------------------------
%% STEP 2: Clear and reconstruct the project data folder
% clean_project; % (Leave commented as a safety)

%% ------------------------------------------------------------
%% STEP 3: Preprocess raw data (wrangling, filtering, formatting)

% fMRI data
preprocess_fmri;
preprocess_mask;

% HR data (convert to csv for use in Kubios software)
preprocess_hr_csv;

%% ******************************
%% ******************************
%% THERE IS A MANUAL KUBIOS 
%% PROCESSING STEP HERE
%% ******************************
%% ******************************

% convert kubios *.mat format to *.csv format for python code
preprocess_hr_kubios_reformat; 

%% ------------------------------------------------------------
%% STEP 4: Format Extrinsic Stimuli Design
format_ex_3dlss; 

%% ------------------------------------------------------------
%% STEP 5: Calculate Extrinsic (EX) Stimuli Beta-Series

% Physio betas (these are the targets)
calc_hr_ex_beta; % bpm trajectories | neutral filtering
calc_hr_ex_bpm;  % bpm targets for mvpa

%% fMRI betas (these are the features)
calc_fmri_ex_beta;

%% ------------------------------------------------------------
%% STEP 6: Conduct MVPA
mvpa_fmri_ex_gm_rgr_v;  % intra-subj (state->valence)

%% ------------------------------------------------------------
%% STEP 7: Compare MVPA (of v) predictions to BPM decleration
analyze_mvpa_vs_bpm_v;

%% ------------------------------------------------------------
%% STEP 8: Interrogate Role of BPM

%Both bpm and svm predict valence (separately)
analyze_pval_vs_val;
analyze_bpm_vs_val;

%Valence explains much of the prediction error
analyze_val_vs_err;
analyze_val_vs_bpm_err;
analyze_bpm_err_vs_err; % they make errors on same stimuli

%BPM explains neither state predictions nor errors
analyze_bpm_vs_pval;
analyze_bpm_vs_err;

%% ------------------------------------------------------------ 
%% STEP 9: Trajectory analysis
analyze_bpm_traj;

%% ------------------------------------------------------------ 
%% STEP 10: Compare Thresholding
analyze_mvpa_vs_bpm_thresh;

%% ------------------------------------------------------------ 
%% STEP 11: Hyperplane analysis
haufe_ex_gm_v_all_permute;

%% ------------------------------------------------------------ 
%% STEP 12: Compare Encoding (SciReport -> Now)
analyze_encoding_v;

toc
