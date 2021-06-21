function [D_AB, number_non_match, number_match, A_not_empty, mask_match_and_zero, mask_dmax, zone_B_match_dmax] = distanceCurveDistance(A,B,dmax, B_distance_transform)
%distanceCurveDistance Compute distance in pixel from pixels set to true in
%A to pixels set to true in B.
%   

N_tot = sum(A(:));

if  N_tot == 0
    % If A contains not curve
    D_AB = 0;
    number_non_match = 0;
    number_match = 0;
    A_not_empty = 0;
    mask_dmax = zeros(size(A,1), size(A,2));
    mask_match_and_zero = zeros(size(A,1), size(A,2));
    zone_B_match_dmax = zeros(size(A,1), size(A,2));
else
    % If A not empty:
    A_not_empty = 1;
    if nargin < 4
        % compute distance transform for B:
        B_distance_transform = TruncatedDistanceTrandsform(B,dmax);
    end
    
    % distance threshold:
    zone_B_match_dmax = B_distance_transform < dmax;
    
    % extract distance to pixels on in B:
    distances_AB = A .* B_distance_transform;
    
    % find far pixels:
    mask_dmax = distances_AB >= dmax;
    mask_match_and_zero = ~mask_dmax; % opposite mask
    
    number_non_match = bwarea(mask_dmax);
    number_match = N_tot - number_non_match;
    % get the distances map only for match
    D_AB = sum(sum(distances_AB .* mask_match_and_zero));

end

