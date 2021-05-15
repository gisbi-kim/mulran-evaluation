clear; clc;
addpath(genpath("../"))

%
calib;

%
filedir = "../data/";
seq_name = "kaist03";
filename = "global_pose_kaist03.csv"; % origianlly was earth-coord.
filepath = fullfile(filedir, filename);

gt_traj = readmatrix(filepath);
gt_traj_xyz = gt_traj(:, [5,9,13]); % column 1: time, column2-13: SE(3) except the last raw [0,0,0,1]

gt_traj_xyz_local = gt_traj_xyz;
gt_traj_xyz_local = gt_traj_xyz_local - gt_traj_xyz(1, :);

%
pose_init = eye(4);
ii_se3_local_prev_ouster = pose_init;

poses_xyz = [pose_init(1:3, 4)'];

gt_traj_local = zeros(size(gt_traj));

for ii = 2:length(gt_traj)
    ii_se3_global_prev_line = gt_traj(ii-1, 2:end);
    ii_se3_global_prev = [reshape(ii_se3_global_prev_line, 4, 3)'; 0,0,0,1];

    ii_se3_global_curr_line = gt_traj(ii, 2:end);
    ii_se3_global_curr = [reshape(ii_se3_global_curr_line, 4, 3)'; 0,0,0,1];
    
    ii_se3_relative_base = ii_se3_global_prev \ ii_se3_global_curr;
    
    ii_se3_local_curr_ouster = ii_se3_local_prev_ouster * (kLidar2BaseMulran * ii_se3_relative_base * kBase2LidarMulran);
    ii_se3_local_prev_ouster = ii_se3_local_curr_ouster;
    
    ii_xyz_local = ii_se3_local_curr_ouster(1:3, 4)';
    poses_xyz = [poses_xyz; ii_xyz_local];
    
    ii_se3_local_curr_line = [ii_se3_local_curr_ouster(1, :), ii_se3_local_curr_ouster(2, :), ii_se3_local_curr_ouster(3, :)];
    
    disp(ii);
    gt_traj_local(ii, :) = [string(uint64(gt_traj(ii, 1))), string(double(ii_se3_local_curr_line))];
end
gt_traj_local = gt_traj_local(2:end, 1:end);

savefilename = filename.char; savefilename = savefilename(1:end-4);

% writematrix(gt_traj_local, fullfile(filedir, "lidarcoord_pose_" + seq_name + ".csv"));
dlmwrite(fullfile(filedir, "lidarcoord_pose_" + seq_name + ".csv"), gt_traj_local,'precision','%.6f');


