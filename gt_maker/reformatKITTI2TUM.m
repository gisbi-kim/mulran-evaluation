clear; clc;
addpath(genpath("../"))

%
filedir = "../data/";
seq_name = "dcc02";
gt_kittiform = readmatrix("lidarcoord_pose_dcc02.csv");
gt_times = gt_kittiform(:, 1);

gt_tumform = [];
for ii=1:length(gt_kittiform)
    time = gt_times(ii);
    trans = gt_kittiform(ii, [5,9,13]);
    rotso3 = transpose(reshape(gt_kittiform(ii, [2,3,4, 6,7,8, 10,11,12]), 3, 3));
    try
        rotquat = UnitQuaternion(rotso3);    
    catch
        continue;
    end
    
    gt_tumform = [gt_tumform; time, trans, rotquat.v, rotquat.s];
end

writematrix(gt_tumform, fullfile(filedir, "lidarcoord_pose_" + seq_name + "_tum_format.csv"));

