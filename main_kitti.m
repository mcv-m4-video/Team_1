close all;
clear all;
clc;

addpath(genpath('.'));

% Read image_0

sq_0_train{1} = imread('./data_stereo_flow/training/image_0/000045_10.png');
sq_0_train{2} = imread('./data_stereo_flow/training/image_0/000045_11.png');

sq_1_train{1} = imread('./data_stereo_flow/training/image_0/000157_10.png');
sq_1_train{2} = imread('./data_stereo_flow/training/image_0/000157_11.png');

sq_0_gt_flow_noc{1} = flow_read('./data_stereo_flow/training/flow_noc/000045_10.png');
sq_0_gt_flow_noc{2} = flow_read('./data_stereo_flow/training/flow_noc/000157_10.png'); 

sq_0_est_kitti_flow_noc{1} = flow_read('./results_kitti/LKflow_000045_10.png');
sq_0_est_kitti_flow_noc{2} = flow_read('./results_kitti/LKflow_000157_10.png');

% Plot figure 1

hold on
figure(1);

t = 1;

subplot(4,2,1);
imshow(sq_0_train{t});
title('Image 45-01')

subplot(4,2,3);
imshow(sq_0_train{t+1});
title('Image 45-02')

subplot(4,2,2)
imshow(sq_1_train{t});
title('Image 157-01')

subplot(4,2,4)
imshow(sq_1_train{t+1});
title('Image 157-02')

subplot(4,2,5);
imshow(flow_to_color(sq_0_gt_flow_noc{t}));
title('GT kitti flow')

subplot(4,2,6);
imshow(flow_to_color(sq_0_gt_flow_noc{t+1}));
title('GT kitti flow')

subplot(4,2,7);
imshow(flow_to_color(sq_0_est_kitti_flow_noc{t}));
title('Est kitti flow')

subplot(4,2,8);
imshow(flow_to_color(sq_0_est_kitti_flow_noc{t+1}));
title('Est kitti flow')
hold off
%% Task 4 Compute the mean magnitude error, MMEN, for all pixels in
% non-ocluded areas.
% 1st test
tau=3;

[MSEN,f_err] = flow_error(sq_0_gt_flow_noc{1},sq_0_est_kitti_flow_noc{1},tau);
F_err = flow_error_image(sq_0_gt_flow_noc{1},sq_0_est_kitti_flow_noc{1});
% figure,imshow([flow_to_color([sq_0_est_kitti_flow_noc{1};sq_0_gt_flow_noc{1}]);F_err]);
figure,imshow(F_err);
title(sprintf('Error: %.2f %%. MSEN: %.2f.',f_err*100,MSEN));
figure,flow_error_histogram(sq_0_gt_flow_noc{1},sq_0_est_kitti_flow_noc{1});
pause;
% 2nd test
close all;
[MSEN,f_err] = flow_error(sq_0_gt_flow_noc{2},sq_0_est_kitti_flow_noc{2},tau);
F_err = flow_error_image(sq_0_gt_flow_noc{2},sq_0_est_kitti_flow_noc{2});
figure,imshow(F_err);
title(sprintf('Error: %.2f %%. MSEN: %.2f.',f_err*100,MSEN));
figure,flow_error_histogram(sq_0_gt_flow_noc{2},sq_0_est_kitti_flow_noc{2});

pause;

%% Task 6

close all

figure(1)
subplot(2,1,1)
plot_opticalFlow(sq_0_gt_flow_noc{1});
title('Ground Truth 1')

subplot(2,1,2)
plot_opticalFlow(sq_0_est_kitti_flow_noc{1});
title('Estimation 1')

pause;

figure(2)
subplot(2,1,1)
plot_opticalFlow(sq_0_gt_flow_noc{2});
title('Ground Truth 2')
subplot(2,1,2)
plot_opticalFlow(sq_0_est_kitti_flow_noc{2});
title('Estimation 2')

