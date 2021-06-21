% Sample code to illustrate the use of the different functions.


%% Define the binary images "prediction" and "groudn-truth"

height = 50;
width = 100;

coord_gt = [1,1;width,height];
I_gt = convertPolyLineIntoBinaryImage(coord_gt(:,1), coord_gt(:,2), height, width);

coord_pred = [10,1; width-10, height];
I_pred = convertPolyLineIntoBinaryImage(coord_pred(:,1), coord_pred(:,2), height, width);

%% Compute distance contour score:

% Define dmax:
dmax = 10;
% dmax = 0.02 * sqrt(height^2 + width^2); % 2% of the diagonal of the image.

[~, scoreStructure] = ContourScore(I_pred, I_gt, dmax);
% note: you can also give the distance transform of the prediction and gt
% binary images if you already computed them.

%% Show results:
