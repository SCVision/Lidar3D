% test akde
data=[randn(10^3,3);randn(10^3,3)/2+2]; % three dimensional data
[n,d]=size(data); 
ng=100; % total grid points = ng^d
MAX=max(data,[],1); 
MIN=min(data,[],1); 
scaling=MAX-MIN;
% create meshgrid in 3-dimensions
[X1,X2,X3]=meshgrid(MIN(1):scaling(1)/(ng-1):MAX(1),...
MIN(2):scaling(2)/(ng-1):MAX(2),MIN(3):scaling(3)/(ng-1):MAX(3));
grid=reshape([X1(:),X2(:),X3(:)],ng^d,d); % create points for plotting
pdf=akde(data,grid); % run adaptive kde
pdf=reshape(pdf,size(X1)); % reshape pdf for use with meshgrid
for iso=[0.0001:0.001:0.015] % isosurfaces with pdf = 0.005,0.01,0.015
    isosurface(X1,X2,X3,pdf,iso),view(3),alpha(.3),box on,hold on,colormap cool
end
