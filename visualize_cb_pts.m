function [] = visualize_cbs(new_coords, cb)
%VISUALIZE_CBS Visualizes new coordinate system for each cb block
% Author: Rose Rustowicz, rose.rustowicz@gmail.com
% Date: 16 March 2018

zer = zeros(1, 1, 3);
zer(:,:,3) = 1;
zer = repmat(zer, [19,19,1]);

[r, c, p] = size(cb);
for idx = 1:numel(new_coords(:,1)+1)
   if p == 1
       cb_3 = repmat(cb, [1, 1, 3]);
   else
       cb_3 = cb;
   end
   cb_3 = double(cb_3/max(double(cb_3(:))));
   coords = round(new_coords(idx,:));
   cb_3(coords(2)-9:coords(2)+9, coords(1)-9:coords(1)+9,:) = zer; %[0 0 1];
   imshow(cb_3)
   cb_3(coords(4)-9:coords(4)+9, coords(3)-9:coords(3)+9,:) = zer; %[0 0 1];
   imshow(cb_3)
   cb_3(coords(6)-9:coords(6)+9, coords(5)-9:coords(5)+9,:) = zer; %[0 0 1];
   imshow(cb_3)
   cb_3(coords(8)-9:coords(8)+9, coords(7)-9:coords(7)+9,:) = zer; %[0 0 1];
   imshow(cb_3)
end

end

