function [ height_map ] = construct_surface( p, q, path_type )
%CONSTRUCT_SURFACE construct the surface function represented as height_map
%   p : measures value of df / dx
%   q : measures value of df / dy
%   path_type: type of path to construct height_map, either 'column',
%   'row', or 'average'
%   height_map: the reconstructed surface


if nargin == 2
    path_type = 'column';
end

[h, w] = size(p);
height_map = zeros(h, w);

switch path_type
    case 'column'
        % =================================================================
        % top left corner of height_map is zero
        % for each pixel in the left column of height_map
        % Left col only
        for height_idx=2:h
           % height_value = previous_height_value + corresponding_q_value
           prev_h_val = height_map(height_idx - 1, 1);
           height_map(height_idx, 1) = prev_h_val + q(height_idx, 1);
        end
        % for each row
        %   for each element of the rows except for leftmost
        %       height_value = previous_height_value + corresponding_p_value
        for height_idx=1:h
           for row_idx=2:w
              prev_h_val = height_map(height_idx, row_idx - 1);
              height_map(height_idx, row_idx) = prev_h_val + p(height_idx, row_idx);
           end
        end
        
       
        % =================================================================
               
    case 'row'
        
        % =================================================================
        % top left corner of height_map is zero
        % for each pixel in the top row of height_map
        % Top row only
        for row_idx=2:w
           % height_value = previous_height_value + corresponding_p_value
           prev_h_val = height_map(1, row_idx - 1);
           height_map(1, row_idx) = prev_h_val + p(1, row_idx);
        end
                
        % for each column
        %  for each element of the cols except for leftmost
        for row_idx=1:w
           for height_idx=2:h
              % height_value = previous_height_value + corresponding_q_value
              prev_h_val = height_map(height_idx - 1, row_idx);
              height_map(height_idx, row_idx) = prev_h_val + q(height_idx, row_idx);
           end
        end
        

        % =================================================================
          
    case 'average'
        % Use the algorithms as columns and rows and averages the two.
        % =================================================================
        height_map_col = zeros(size(height_map));
        height_map_row = zeros(size(height_map));
        height_map_avg = zeros(size(height_map));
        
        % COLS-Major
        for height_idx=2:h
           prev_h_val = height_map_col(height_idx - 1, 1);
           height_map_col(height_idx, 1) = prev_h_val + q(height_idx, 1);
        end
        
        for height_idx=1:h
           for row_idx=2:w
              prev_h_val = height_map_col(height_idx, row_idx - 1);
              height_map_col(height_idx, row_idx) = prev_h_val + p(height_idx, row_idx);
           end
        end
        
        % ROWS-Major
        for row_idx=2:w
           prev_h_val = height_map_row(1, row_idx - 1);
           height_map_row(1, row_idx) = prev_h_val + p(1, row_idx);
        end
        
        for row_idx=1:w
           for height_idx=2:h
              prev_h_val = height_map_row(height_idx - 1, row_idx);
              height_map_row(height_idx, row_idx) = prev_h_val + q(height_idx, row_idx);
           end
        end
        
        height_map_avg = (height_map_row + height_map_col ) ./ 2;
        height_map = height_map_avg;
        % =================================================================
end


end

