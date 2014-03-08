function [ connectedmask ] = findGridConnectedToPath( V, E3, node, path, dims )
%Returns a mask of size dims corresponding to the grid represented by V,E3
%with weights 1 for nodes which are connected to node through paths
%which do not contain nodes in path and zeros everywhere else
   list = zeros(size(E3(:,1)));
   for i=1:size(E3,1)
       for j=1:size(path,2)
           k = E3(i,:);
           if (k(1) == path(j)) || (k(2) == path(j))
               list(i) = 1;
           end
       end
   end   
   E3(logical(list),:) = [];
   
   DG = sparse(E3(:,1),E3(:,2),true,size(V,1),size(V,1));
   found = (bfs(DG,node)+1)>0;
   
   connectedmask = logical(zeros(dims));
   for x=1:dims(2)
       for y=1:dims(1)
           connectedmask(y,x) = found((x-1)*dims(1)+y);
       end
   end
   
   
end