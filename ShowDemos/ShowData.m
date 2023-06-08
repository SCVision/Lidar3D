% Show data in 'Data'
path(path,'..\Funcs')

%% read data 
% fn = 'Scan3D20230409202854.L3D';
fn = 'Scan3D20230529104817.L3D';
[rData, angleV, angleH, timestamp, datumSize, ...
    La, Lx, Dpsi, Dtheta, Dgamma] = read_L3D(fn); 

%% show raw data
figure(1); plot(angleH,'.')
figure(2); plot(timestamp,'.')
% figure(1); plot(angleV)

%% show point cloud
La = 0; Lx = 0;
Dpsi=0; Dtheta=0.7; Dgamma=0;
ps = dist2points(rData, angleV, angleH, ...
    La, Lx, Dpsi, Dtheta, Dgamma);

figure(10); 
c = ps(:,4); c(c>2) = 2;
% scatter3(ps(:,1),ps(:,2),ps(:,3),1,c);
scatter3(ps(:,1),ps(:,2),ps(:,3),1);
az = -38; el = -4; view(az,el)
xlim([-5,5]); ylim([-5 5]); 
zlim([-2,3])
% xlim(xl); ylim(yl); zlim(zl)
xlabel('x'); ylabel('y'); zlabel('z'); 

