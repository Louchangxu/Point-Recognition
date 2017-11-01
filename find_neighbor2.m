%% Find the nearby points of the selected poing
function  neighbor  = find_neighbor2( point )
global number;
global ptCloud;
neighbor = zeros;
s = 1;

for i=1:number
    sum = norm(ptCloud.Location(point,:)-ptCloud.Location(i,:));
    if sum <= 5 && point ~= i
        neighbor(s) = i;
        s = s+1;
         scatter3(ptCloud.Location(neighbor(s-1),1),ptCloud.Location(neighbor(s-1),2),ptCloud.Location(neighbor(s-1),3),'filled' );
    end
end
return;
end