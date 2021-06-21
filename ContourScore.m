function [score, scoreStructure] = ContourScore(I_pred,I_gt,dmax, DT_pred,DT_gt)
%ContourScore Score proposed in [1] to compare two contour map.
%   
%   [1] François et al. IJCARS 2020

assert(size(I_pred,1) == size(I_gt,1) && size(I_pred,2) == size(I_gt,2), 'Error input images should have same size'); 

if ~exist('DT_A','var')
    DT_pred = TruncatedDistanceTrandsform(I_pred, dmax);
end
if ~exist('DT_B','var')
    DT_gt = TruncatedDistanceTrandsform(I_gt, dmax);
end

% Compute distances between both lines
[D_pred_to_gt, fp, match_pred, ~, mask_tp_pred, mask_fp] = distanceCurveDistance(I_pred,I_gt,dmax,DT_gt);
[D_gt_to_pred, fn, match_gt, ~, mask_tp_gt, mask_fn] = distanceCurveDistance(I_gt,I_pred,dmax, DT_pred);

% get total number of pixels in image and gt:
n_pixel_image = size(I_pred,1) * size(I_pred,2);
n_tot_gt = fn + match_gt;

% Compute score for TP and FN
if n_tot_gt == 0
    D_TP = 0;
    D_FN = 0;
else
    D_TP = (D_pred_to_gt + D_gt_to_pred) / (2.0 * n_tot_gt);
    D_FN = dmax * fn / (1.0*n_tot_gt);
end

% Compute score for FP
denom_FP = n_pixel_image - (2*dmax*n_tot_gt);

if denom_FP == 0
    D_FP = 0;
else
    D_FP = dmax * fp / (1.0*denom_FP);
end
score_pixel = (D_TP + D_FN + D_FP);
score = score_pixel/ dmax;

% save strcuture
scoreStructure.score = score;
scoreStructure.score_pixel = score_pixel;
scoreStructure.S_TP = D_TP;
scoreStructure.S_FP = D_FP;
scoreStructure.S_FN = D_FN;
scoreStructure.dmax = dmax;
scoreStructure.fp_spatial_support = denom_FP;
scoreStructure.gt_total = n_tot_gt;

% visualization:
scoreStructure.mask_tp_pred = mask_tp_pred;
scoreStructure.mask_tp_gt = mask_tp_gt;
scoreStructure.mask_fn = mask_fn;
scoreStructure.mask_fp = mask_fp;

end

