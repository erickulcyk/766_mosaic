function [ V,E3 ] = buildUpGridOnPath(V,cV,weights,cpath,dims )
    E3 = zeros([400*size(cpath,2),3]);
    i=1;
    
    %only check blocks on the path
    for b=1:size(cpath,2)
       j=1;
       bV = zeros([100,1]);
       %find the nodes in block b
       llcrds = 10.*(cV(cpath(b),:)-[1,1]);
       for x=llcrds(2)+(1:10)
          for y=llcrds(1)+(1:10)
             %check if this node is on the grid
             if sum([y,x] <= dims)==2
                bV(j) = (x-1)*dims(1)+y;
                j=j+1;
             end
          end
       end
       bV = bV(1:j-1);
       %for each of those nodes, generate their edges
       for bn=1:size(bV,1)
          n=bV(bn);
          %check downward transition
          if n+1 <= size(V,1)
             %do we stay in the block?
             if sum(cV(cpath(b),:)==ceil((V(n,:)+[1,0])/10))==2
                 E3(i,:) = [n,n+1,weights(V(n+1,1),V(n+1,2))];
                 i=i+1;
             else
                %moving between blocks-- do they appear in order on our path?
                if b<size(cpath,2)
                   %is it the block after b on cpath?
                   if sum(ceil((V(n,:)+[1,0])/10)==cV(cpath(b+1),:))==2
                      E3(i,:) = [n,n+1,weights(V(n+1,1),V(n+1,2))];
                      i=i+1;
                   end
                end
                if b>1
                   %is it the block before b on cpath?
                   if sum(ceil((V(n,:)+[1,0])/10)==cV(cpath(b-1),:))==2
                      E3(i,:) = [n,n+1,weights(V(n+1,1),V(n+1,2))];
                      i=i+1;
                   end
                end
             end
          end
          %check upward transition
          if n-1 > 0
             %do we stay in the block?
             if sum(cV(cpath(b),:)==ceil((V(n,:)-[1,0])/10))==2
                E3(i,:) = [n,n-1,weights(V(n-1,1),V(n-1,2))];
                i=i+1;
             else
                %moving between blocks-- do they appear in order on our path?
                if b<size(cpath,2)
                   %is it the block after b on cpath?
                   if sum(ceil((V(n,:)-[1,0])/10)==cV(cpath(b+1),:))==2
                      E3(i,:) = [n,n-1,weights(V(n-1,1),V(n-1,2))];
                      i=i+1;
                   end
                end
                if b>1
                   %is it the block before b on cpath?
                   if sum(ceil((V(n,:)-[1,0])/10)==cV(cpath(b-1),:))==2
                      E3(i,:) = [n,n-1,weights(V(n-1,1),V(n-1,2))];
                      i=i+1;
                   end
                end
             end
          end
          %check rightward transition
          if n+dims(1) <= size(V,1)
             %do we stay in the block?
             if sum(cV(cpath(b),:)==ceil((V(n,:)+[0,1])/10))==2
                E3(i,:) = [n,n+dims(1),weights(V(n+dims(1),1),V(n+dims(1),2))];
                i=i+1;
             else
                %moving between blocks-- do they appear in order on our path?
                if b<size(cpath,2)
                   if sum(ceil((V(n,:)+[0,1])/10)==cV(cpath(b+1),:))==2
                      E3(i,:) = [n,n+dims(1),weights(V(n+dims(1),1),V(n+dims(1),2))];
                      i=i+1;
                   end
                end
                if b>1
                   if sum(ceil((V(n,:)+[0,1])/10)==cV(cpath(b-1),:))==2
                      E3(i,:) = [n,n+dims(1),weights(V(n+dims(1),1),V(n+dims(1),2))];
                      i=i+1;
                   end
                end
             end
          end
          %check leftward transition
          if n-dims(1)>0
             %do we stay in block b?
             if sum(cV(cpath(b),:)==ceil((V(n,:)-[0,1])/10))==2
                E3(i,:) = [n,n-dims(1),weights(V(n-dims(1),1),V(n-dims(1),2))];
                i=i+1;
             else
                %moving between blocks-- do they appear in order on our path?
                if b<size(cpath,2)
                   if sum(ceil((V(n,:)-[0,1])/10)==cV(cpath(b+1),:))==2
                      E3(i,:) = [n,n-dims(1),weights(V(n-dims(1),1),V(n-dims(1),2))];
                      i=i+1;
                   end
                end
                if b>1
                   if sum(ceil((V(n,:)-[0,1])/10)==cV(cpath(b-1),:))==2
                      E3(i,:) = [n,n-dims(1),weights(V(n-dims(1),1),V(n-dims(1),2))];
                      i=i+1;
                   end
                end   
             end
          end
       end
    end
    E3 = E3(1:i-1,:);
end

