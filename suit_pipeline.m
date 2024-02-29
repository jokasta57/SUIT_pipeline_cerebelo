%VBM - SUIT cerebellum
% si te marca error, es porque no has ejecutado "spm"

clc, clear

tic

#Agregar el nombre de tus imágenes, *.nii, sin la extensión
subjName = {'351_SAG_3D_ACELERATED_MPRAGE_20211019120024_201_std_roi'
    '505_SAG_3D_ACELERATED_MPRAGE_20210806115603_201_std_roi'
    '753_SAG_3D_ACELERATED_MPRAGE_20210611154940_1401_std_roi'
    '407_SAG_3D_ACELERATED_MPRAGE_20211202115511_201_std_roi'
    '673_SAG_3D_ACELERATED_MPRAGE_20210915113354_201_std_roi'};


% Segmentacion del cerebelo
for s = 1:length(subjName) % for each subject
     suit_isolate_seg({[subjName{s} '.nii']});
end

% Normalize

for s = 1:length(subjName) % for each subject
    job.subjND.gray = {['' subjName{s} '_seg1.nii']}; % where subjName is a cell array of subject names
    job.subjND.white = {['' subjName{s} '_seg2.nii']};
    job.subjND.isolation = {['c_' subjName{s} '_pcereb.nii']};
    suit_normalize_dartel(job);

end


% Reslice - VBM

for s=1:length(subjName)

    job.subj.affineTr={['Affine_' subjName{s} '_seg1.mat']};       % where subjName is a cell array of subject names
    job.subj.flowfield={['u_a_' subjName{s} '_seg1.nii']};

    job.subj.resample={['' subjName{s} '_seg1.nii']}; % we are going to change the field resample on our job structure. we type job.subj.resample = to the seg1 image.

    job.subj.mask={['c_' subjName{s} '_pcereb.nii']}; % Mask to be applied

    job.jactransf=1; %we want to modulate the GM probability based on the jacobi
    
    suit_reslice_dartel(job);
end;


toc
