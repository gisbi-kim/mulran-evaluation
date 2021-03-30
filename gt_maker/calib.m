
% Mulran dataset 
se3_6d = [1.7042    -0.021    1.8047    0.0001    0.0003  179.6654]; % for MulRan

trans = se3_6d(1:3);

roll = se3_6d(4); 
pitch = se3_6d(5); 
yaw = se3_6d(6);
rot = rotz(yaw, 'deg') * roty(pitch, 'deg') * rotx(roll, 'deg');

kLidar2BaseMulran = [rot, trans'; 0, 0, 0, 1];
kBase2LidarMulran = inv(kLidar2BaseMulran);