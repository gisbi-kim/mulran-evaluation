# mulran-evaluation

1. run makeGTLiDARCoord (KITTI format. i.e., first 12 elements of SE(3), rowwise, in a single line per keframe)
2. run reformatKITTI2TUM if you want to use rpg evaluator 
3. use drawTrajectories to check visually your GT conversion (w.r.t lidar coord) is correct. 

## TODO
- add example video about how to use rgp_evaluator and evo  
