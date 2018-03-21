function [block] = generate_block(u_column, M, R)
% for each column of u, make a M x M matrix, then cut to M x R
% Authors: Ashwini Ramamoorthy and Rose Rustowicz, rose.rustowicz@gmail.com
% Date: 16 March 2018

    block_init = zeros(M, M);
    half_width = round((R-1)/2);
    % assigning first row
    cur_u_col = circshift(u_column, half_width)';

    % circshifting for other rows
    for m2 = 1:M
        block_init(m2,:) = circshift(cur_u_col, -(m2-1));
    end

    % truncating to M x R shape
    block = block_init(:,1:R);
end

