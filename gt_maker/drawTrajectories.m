clear; clc; 

filedir = "../data/";
addpath(genpath(filedir));

traj_filenames = ["global_pose_dcc01.csv", "lidarcoord_pose_dcc01.csv"];
titles = ["global coord w.r.t earth", "local coord w.r.t lidar sensor"];

for ii = 1:length(traj_filenames)
    
    traj_filename = traj_filenames{ii};
    traj = readmatrix(fullfile(filedir, traj_filename));
    traj_xyz = traj(:, [5,9,13]); % xyz 
    
    figure(1); 
    subplot(1,2, ii);
    ptsize = 100;
    pcshow(traj_xyz, 'MarkerSize', ptsize); hold on; 
    title(titles(ii));
    xlabel('x (m)');
    ylabel('y (m)');
    zlabel('z (m)');
    view(0, 90);
    grid minor;
end
% note that in this example (dcc01, MulRan), in local coordinate, the car
% go along -x axis because the lidar sensor mounted yaw reversed. see
% details calib.m, or the website and Ouster LiDAR spec sheet. 


