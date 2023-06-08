function pnts = range2points2D(rData, angleV, Dgamma) 
% Function: convert 2D LIDAR range data to point sets.
% Input:
%     rData - 2D LIDAR range data (V*1). 
%     angleV - angles (V*1).
%     Dgamma - 2D LiDAR parameter 
% Output:
%     pnts - xL, yL, zL coordinates of points (V*3)
%            yL is zeros if Dgamma = 0;
% Demo:
% [rData, angleV, angleH, timestamp] = read_scandata('Scanned1.txt'); 
% iPhi = 100;
% Dgamma = 0;
% ps = range2points2D(rData(iPhi,:)',angleV,Dgamma);
% figure(1); 
% scatter3(ps(:,1),ps(:,2),ps(:,3),1,'.'); 
% xlabel('x'); ylabel('y'); zlabel('z'); 
% figure(2); plot(ps(:,1), ps(:,3),'b.')
%
% Writen by LIN, Jingyu (linjy02@hotmail.com), 20210426
%
SV = sind(angleV(:)); CV = cosd(angleV(:)); 
Cgamma = cosd(Dgamma); Sgamma = sind(Dgamma);
rc = rData(:)*Cgamma;
yL = -rData(:)*Sgamma;
xL = rc.*SV;
zL = rc.*CV;
% xL = rData.*SV; % Cartesian coordinates
% zL = rData.*CV; % Cartesian coordinates
pnts = [xL,yL,zL];