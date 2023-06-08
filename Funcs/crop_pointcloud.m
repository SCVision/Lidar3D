function [pointsin, pointsout] = crop_pointcloud(points, region) 
% Function: segment points inside and outside a box or a sphere.
% Input:
%     points - X, Y, Z coordinates of points (n * 3).
%     region - definition of the box: [x1 y1 z1; x2 y2 z2]
%              or the sphere: [x,y,z,r]
% Output:
%     pointsin - X, Y, Z coordinates of points in the region (n_in * 3)
%     pointsout - X, Y, Z coordinates of points out of the region ((n-n_in)*3)
% Demo:
% R = 0.2; Dtheta = 0;
% [range, angleV, angleH, timestamp] = read_scandata('Scanned1.txt'); 
% ps = Rang2Points(range, angleV, angleH, R, Dtheta);
% x1 = -5; x2 = 0;
% y1 = -5; y2 = 2;
% z1 = -5; z2 = 1;
% [psin, psout] = crop_pointcloud(ps, [x1, y1, z1; x2, y2, z2]) 
% figure(1); 
% scatter3(psin(:,1),psin(:,2),psin(:,3),1,'.'); xlabel('x'); ylabel('y'); zlabel('z'); 
% 
% Writen by LIN, Jingyu (linjy02@hotmail.com), 20200202
% 20201228: add sphere region
%
if size(region,1) == 2 && size(region,2) == 3
    % box region
    x1 = region(1,1); x2 = region(2,1);
    y1 = region(1,2); y2 = region(2,2);
    z1 = region(1,3); z2 = region(2,3);
    rgn = 0;
elseif length(region) == 4
    % sphere region
    x1 = region(1);
    y1 = region(2);
    z1 = region(3);
    r2 = region(4)*region(4);
    rgn = 1;
else
    % invalid region
    pointsin = [];
    pointsout = points;
    return
end

% traverse all points
n = length(points);
pointBin = zeros(n,3);
n_in = 0; n_out = 0;
for i = 1:n
    % check if the point in the region
    bIn = false; % flag for points in the region
    if rgn == 0
        if points(i,1)>=x1 && points(i,1)<=x2 && ...
                points(i,2)>=y1 && points(i,2)<=y2 && ...
                points(i,3)>=z1 && points(i,3)<=z2
            bIn = true;
        end
    elseif rgn == 1
        dx = points(i,1) - x1;
        dy = points(i,2) - y1;
        dz = points(i,3) - z1;
        if dx*dx+dy*dy+dz*dz <= r2
                bIn = true;
        end
    end
    % distribute points
    if bIn
        n_in = n_in + 1;
        pointBin(n_in,1) = points(i,1); 
        pointBin(n_in,2) = points(i,2);
        pointBin(n_in,3) = points(i,3);
    else
        pointBin(n-n_out,1) = points(i,1); 
        pointBin(n-n_out,2) = points(i,2);
        pointBin(n-n_out,3) = points(i,3);
        n_out = n_out + 1;
    end
end
pointsin = pointBin(1:n_in,:);
pointsout = pointBin(n:-1:n-n_out+1,:);