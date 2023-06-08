function [Np,Dp,err] = plane_params(ps) 
% Function: estimate plane equation Np'*X = Dp from points on the plane.
% Input:
%     ps - x, y, z coordinates of points on a plane (N * 3).
% Output:
%     Np - plane normal (3*1). Np'*Np=1. 
%     Dp - distance from the origin to the plane. 
%          Dp<0 if Np points to the origin.
% 
% Writen by LIN, Jingyu (linjy02@hotmail.com), 20210513
%
[coeff,~,latent] = pca(ps);
Np = coeff(:,3);
err = latent(3);
Dp = mean(ps*Np);