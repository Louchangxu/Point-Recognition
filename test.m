close all;
clear;
clc;
%% Initiaalization
global Normal;
global ptCloud;
global number;
%% Read the point cloud
ptCloud = pcread('cube.ply');
[number,~]= size(ptCloud.Location);
subplot(2,2,1);
pcshow(ptCloud);
hold on;
% hold on;
%% Normalize the normal vectors
Normal = normr(ptCloud.Normal);
%% Find the first level point and calculate the feature
n = round(rand*number + 0.5);%%%%%%%%%%%%%%%%%%%%%
s = 20;
f = zeros;
Sp = find_neighbor2( n  );
fs = 1;
for i=1:s
    if Sp(i) ~= n
        [ f(fs,1),f(fs,2),f(fs,3),f(fs,4) ] = point_feature( n, Sp(i));
        SSp = find_neighbor2( Sp(i) );
        fs = fs+1;
        for k=1:s
            if SSp(k) ~= Sp(i)
                [ f(fs,1),f(fs,2),f(fs,3),f(fs,4) ] = point_feature( Sp(i), SSp(k));
                fs = fs+1;
            end
        end
    end
end
A = f;
meana = mean(A);
[a ,~] = size(A);
AA = A - repmat(meana,a,1);
%% part 2
subplot(2,2,3);
pcshow(ptCloud);
hold on;
n = round(rand*number + 0.5);%%%%%%%%%%%%%%%%%%%%%
s = 20;
f = zeros;
Sp = find_neighbor2( n );
fs = 1;
for i=1:s
    if Sp(i) ~= n
        [ f(fs,1),f(fs,2),f(fs,3),f(fs,4) ] = point_feature( n, Sp(i));
        SSp = find_neighbor2( Sp(i));
        fs = fs+1;
        for k=1:s
            if SSp(k) ~= Sp(i)
                [ f(fs,1),f(fs,2),f(fs,3),f(fs,4) ] = point_feature( Sp(i), SSp(k));
                fs = fs+1;
            end
        end
    end
end
B = f;
meanb = mean(B);
[b ,~] = size(B);
BB = B - repmat(meanb,b,1);
r = a;
if a>b
    r = b;
    for i = b+1:a
        AA(b+1,:) = [];
    end
end
if a<b
    r = a;
    for i = a+1:b
        BB(a+1,:) = [];
    end
end
T = BB - AA;
T = mapminmax(T)./2+0.5*ones(r,4);
tt = round(r/2);
T = repmat(T,1,tt);
T1 = T+j*T;
C = T1*T1'.*(1e12);
E1 = eig(C);
subplot(2,2,2);
[count , m]=hist(E1 , 0:0.01:1);
[u, v]=size(count);
count(v)=0;
count(1)=0;
cla reset
bar(m, count./(r*0.5*0.01),'y')
% histn(E1,0,0.01,1);
subplot(2,2,4);
H=trnd(2,r,r*2);
X=H*H'./(r*2);
E=eig(X);

[count , m]=hist(E , 0:0.01:4);
[u, v]=size(count);
count(v)=0;
cla reset
bar(m, count./(r*0.5*0.01),'y')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% R = trnd(2,r,r*2)+j*trnd(2,r,r*2);
% C2 = R*R'./(r*2);
% E2 = eig(C2);
% histn(E2,0,0.01,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [count , m]=hist(E2 , 0:0.01:1);
% [u, v]=size(count);
% count(v)=0;
% count(1)=0;
% cla reset
% bar(m, count./(r*0.5*0.01),'y')