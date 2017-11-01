%% Find the 4 point features between 2 points
function [f1,f2,f3,f4] = point_feature(point1,point2)
global Normal;
global ptCloud;
% Calculate the distance betweent 2 points
line = ( ptCloud.Location(point2,:)-ptCloud.Location(point1,:) )';
sum = norm(line);
% Calculate the frame u,v,w
u = Normal( point1 , : )';
v = cross(line,u)./sum;
w = cross(u,v);
% Calculate the 4 features
a = dot(w , Normal(point2 , :));
b = dot(u ,  Normal(point2 , :));
f1 = dot( v , Normal(point2,:)  );
f2 = dot( u , line )/sum;
f4 = sum;
if a>0 && b>0
    f3 = atan(b/a);
else
    if a>0 && b<0
        f3 = atan(b/a) + 2*pi;
    else
        f3 = atan(b/a) + pi;
    end
end
return;
end