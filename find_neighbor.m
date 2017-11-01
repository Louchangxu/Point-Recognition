%% Find the k nearby points of the selected point
function  neighbor  = find_neighbor( point , k )
%global number;
global ptCloud;
%X = ptCloud.Location(ptCloud.Location);
Y = ptCloud.Location(point,:);
Mdl = KDTreeSearcher(ptCloud.Location);
[Idx,~] = knnsearch(Mdl,Y,'K',k,'IncludeTies',true);
neighbor = Idx{1}';
scatter3(ptCloud.Location(neighbor,1),ptCloud.Location(neighbor,2),ptCloud.Location(neighbor,3),'filled' );
return;
end