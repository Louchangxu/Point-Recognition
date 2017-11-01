close all;
clear;
clc;
%% Initiaalization
global Normal;
global ptCloud;
global number;
%% Read the point cloud
ptCloud = pcread('sphere.ply');
[number,~]= size(ptCloud.Location);
subplot(1,2,1);
n = round(rand*number + 0.5); % The selected point
pcshow(ptCloud);
hold on;
%% Normalize the normal vectors
Normal = normr(ptCloud.Normal);
%% Find the first level point and calculate the feature
for ttt = 1:1 %%%%%%%%%%%%%%%%%%%%%
% n = round(rand*number + 0.5);%%%%%%%%%%%%%%%%%%%%%
s = 30;
f = zeros;
Sp = find_neighbor( n , s );
fs = 1;
for i=1:s
    if Sp(i) ~= n
        [ f(fs,1),f(fs,2),f(fs,3),f(fs,4) ] = point_feature( n, Sp(i));
        SSp = find_neighbor( Sp(i) , s );
        fs = fs+1;
        for j=1:s
            if SSp(j) ~= Sp(i)
                [ f(fs,1),f(fs,2),f(fs,3),f(fs,4) ] = point_feature( Sp(i), SSp(j));
                fs = fs+1;
            end
        end
    end
end
fs = fs-1;
binvalues = zeros(1,81);
nn = zeros;
maximum = zeros;
minimum = zeros;
for i = 1:4
    maximum(i) = max(f(:,i));
    minimum(i) = min(f(:,i));
end
for i=1:fs
    nnn = 0;
    for j=1:4
        switch 1
            case f(i,j)<=( maximum(j)/3+minimum(j)*2/3)
                nn(j) = 1;
            case f(i,j)<=( maximum(j)*2/3+minimum(j)/3)
                nn(j) = 2;
            case f(i,j)>( maximum(j)*2/3+minimum(j)/3)
                nn(j) = 3;
        end
        nnn = nnn+nn(j)*(3^(j-1));
    end
    nnn = nnn-39;
    binvalues(1,nnn) = binvalues(1,nnn)+1;
end
binvalues4 = normr(binvalues);
x=0:1:80;
subplot(1,2,2);
% subplot(1,5,ttt)
plot(x,binvalues4);
hold on;
end