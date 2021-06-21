function [I_show_final] = showContourScore(scoreStructure)
%SHOWCONTOURSCORE Summary of this function goes here
%   Detailed explanation goes here

mask_pred = scoreStructure.mask_tp_pred;
I_show = zeros(size(mask_pred,1), size(mask_pred,2), 3);
red_show = I_show(:,:,1);
green_show = I_show(:,:,2);
blue_show = I_show(:,:,3);

% tp_pred = [0,255,0]
% tp_gt = [0,0,255]
% fp = [255,0,0]
% fn = [150,0,150]

% Mark pixels
% TP:
green_show(logical(scoreStructure.mask_tp_pred)) = 255;
blue_show(logical(scoreStructure.mask_tp_gt)) = 255;

% FP:
red_show(logical(scoreStructure.mask_fp)) = 255;

% FN:
red_show(logical(scoreStructure.mask_fn)) = 150;
blue_show(logical(scoreStructure.mask_fn)) = 150;

I_show_final =  cat(3, red_show, green_show, blue_show);


% plot dmax area around curves:
B_dmax_gt = bwboundaries(scoreStructure.mask_zone_dmax_gt);
B_dmax_pred = bwboundaries(scoreStructure.mask_zone_dmax_pred);
B_dmax_gt = B_dmax_gt{:};
B_dmax_pred=B_dmax_pred{:};

figure, imshow(I_show_final)
hold on
plot(B_dmax_pred(:,2),B_dmax_pred(:,1), 'g--')
plot(B_dmax_gt(:,2), B_dmax_gt(:,1), 'b--')

h_lgd = legend('dmax prediction zone', 'dmax gt zone', 'tp pred', 'tp gt', 'fn', 'fp');
score_px = scoreStructure.score_pixel;
s_tp = scoreStructure.S_TP;
s_fp = scoreStructure.S_FP;
s_fn = scoreStructure.S_FN;

score_format = '%1.2f';
title(['Score = ' num2str(score_px,score_format) 'px, S_{TP} = ' num2str(s_tp,score_format) 'px, S_{FP} = ' num2str(s_fp,score_format) 'px, S_{FN} = ' num2str(s_fn,score_format) 'px']);
xlabel(['d_{max} = ' num2str(scoreStructure.dmax,score_format) 'px'])

end

