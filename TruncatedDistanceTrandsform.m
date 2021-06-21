function [A_tdt] = TruncatedDistanceTrandsform(A,dmax)
%TRUNCATEDDISTANCETRANDSFORM Compute the truncated distance transform of a
%binary array.
%   Note: this handles when the given binary image is only zeros.

dt = bwdist(A);

% find values where distance transform is greater than threshold distance
mask_dmax = dt >= dmax;

% Apply threshold value on mask:
A_tdt = dt;
A_tdt(mask_dmax) = dmax;

end

