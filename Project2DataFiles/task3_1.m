%Loading the parameters
x = load('Parameters_V1_1.mat');
x = x.Parameters;
y = load('Parameters_V2_1.mat');
y = y.Parameters;

%Loading mocap points
mocap_points = load('mocapPoints3D.mat');
mocap_points = mocap_points.pts3D;

ltemp = zeros(4,39);
ltemp2 = zeros(3,39);
rtemp = zeros(4,39);
rtemp2 = zeros(3,39);

for point = 1:39
    tDpoint = mocap_points(:,point);
    translate = zeros(4,4);
    translate(1:3,:) = x.Pmat;
    translate(4,4) = 1;
    rotate = zeros(4,4);
    rotate(1:3,1:3) = x.Rmat;
    rotate(4,4) = 1;

    ltemp(:,point) =  translate * [tDpoint; 1];
    ltemp2(1,point) = ltemp(1,point)/ltemp(3,point);
    ltemp2(2,point) = ltemp(2,point)/ltemp(3,point);
    ltemp2(3,point) = 1;
    ltemp2(:,point) = x.Kmat * ltemp2(:,point);
end



for point = 1:39
    tDpoint = mocap_points(:,point);
    translate = zeros(4,4);
    translate(1:3,:) = y.Pmat;
    translate(4,4) = 1;
    rotate = zeros(4,4);
    rotate(1:3,1:3) = y.Rmat;
    rotate(4,4) = 1;
    rtemp(:,point) =  translate * [tDpoint; 1];

    rtemp2(1,point) = rtemp(1,point) / rtemp(3,point);
    rtemp2(2,point) = rtemp(2,point) / rtemp(3,point);
    rtemp2(3,point) = 1;
    rtemp2(:,point) = y.Kmat * rtemp2(:,point);
end

res1 = ltemp2(1:2,:);
res2 = rtemp2(1:2,:);

im = imread('im1corrected.jpg');
im2 = imread('im2corrected.jpg');
figure(1); imagesc(im);
hold on;
for i=1:size(res1,2)
    h = plot(res1(1,i),res1(2,i),'*'); 
    set(h,'Color','r','LineWidth',2);
end
hold off;
figure(2); imagesc(im2);
hold on;
for i=1:size(res2,2)
    h = plot(res2(1,i),res2(2,i),'*'); 
    set(h,'Color','r','LineWidth',2);
end
hold off;