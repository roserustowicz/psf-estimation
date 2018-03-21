function [u_circ,u,k] = generate_block_circ_u(u,R)
% Authors: Ashwini Ramamoorthy and Rose Rustowicz, rose.rustowicz@gmail.com
% Date: 16 March 2018
    
    % initializing variables
    M = size(u,1);
    N = size(u,2);
    
    half_width = round((R-1)/2); % this works well for odd R
    
    u_circ = zeros(M*N,N*R);
    first_block = zeros(M,N*R);

    % finding column indexes
    column_index = 1:N;
    column_index = circshift(column_index,half_width);

    % generating the first row
    for i = 1:N
        col = column_index(i);
        u_col = u(:,col);

        % calling Rose's function - returns an MxR block
        first_block(:,((i-1)*R)+1 : i*R) = generate_block(u_col, M, R);

    end

    % generating u circ matrix
    u_circ(1:M,:) = first_block;
    for i = 1:N-1
        u_circ((i*M)+1 : (i+1)*M, :) = circshift(first_block,-R,2);
        first_block = circshift(first_block,-R,2);
    end

    % truncating u
    u_circ(:,(R*R)+1:end) = [];

    % validating results
    %b1 = u_circ*k(:);
    %b1 = reshape(b1,[size(u,1),size(u,2)]);
    %b2 = imfilter(u,k,'circular');
    %disp(b1)
    %disp(b2)
    %disp(b1 - b2)
end