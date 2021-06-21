function I = convertPolyLineIntoBinaryImage(x_coord, y_coord, height, width)
%CONVERTPLYLINEINTOBINARYIMAGE Convert set of coordinates describing a set
%of polylines into a binary image.
%   x_coord is a cell/array of the x-coordinates of the vertices of the given polyline.
%   y_coord is a cell/array of the y-coordinates of the vertices of the given polyline.
%   The function connects vertices the same cell, and leaves separated the
%   different cells.
%   height, width define the dimensions of the output image.

I = zeros(height,width,3);
% line_width = 1;
if ~iscell(x_coord)
    x_coord = {x_coord};
    y_coord = {y_coord};
end
for i =1:length(x_coord)
    if isempty(x_coord{i})
        
    elseif length(x_coord{i}) == 1
        I(x_coord{i}(1), y_coord{i}(1),:) = 1;
    else
        for i_line=1:length(x_coord{i}) -1
            
            I = insertShape(I, 'Line', [x_coord{i}(i_line),y_coord{i}(i_line), x_coord{i}(i_line+1),y_coord{i}(i_line+1)], ...
                'Color', 'white', 'Opacity', 1.0, 'Smoothedges', false);  
        end
        
    end
    
end
I = I(:,:,1);
end

