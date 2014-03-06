function [ pathout ] = imdijkstra(img1,img2)
    %Constructs masks for the defined region of each image
    % Assumes black rows and columns are outside the image regions   
    img11 = img1(:,:,1)>0;
    img12 = img1(:,:,2)>0;
    img13 = img1(:,:,3)>0;
    img1def = img11 | img12 | img13;
    img21 = img2(:,:,1)>0;
    img22 = img2(:,:,2)>0;
    img23 = img2(:,:,3)>0;
    img2def = img21 | img22 | img23;
    
    % Intersect the two images to find overlapping region
    intsect = img1def & img2def;
    [minx,miny,maxx,maxy] = findboundsofmask(intsect);
    
    % Determine at which corners we want to start and end our path
    if ((minx==1 && miny==1) || inorof(img1def,img2def,minx-1,miny-1))
        startnode = [minx,maxy];
        endnode = [maxx,miny];
    else
        startnode = [minx,miny];
        endnode = [maxx,maxy];
    end
    
    disp('found intersect, computing differences');
    
    %find difference on intersect region -- this is our weighting function
    for i=minx:maxx;
        for j=miny:maxy;
            weights(j,i) = abs(img1(j,i)-img2(j,i));
        end
    end
    
    disp('done with differencing, preparing graph');
    %Create graph for Djikstra
    n=1;
    i=1;
    ndes = zeros(size(intsect,1)*size(intsect,2),2);
    edgs = zeros(2,3);
    for x=1:(size(intsect,2)-1)
        for y=1:(size(intsect,1)-1)
            %set up the node coordinate matrices and the edge connections
            edgs(i,:) = [n,n+1,weights(y,x+1)];
            edgs(i+1,:) = [n+1,n,weights(y,x)];
            edgs(i+2,:) = [n,n+size(intsect,2),weights(y+1,x)];
            edgs(i+3,:) = [n+size(intsect,2),n,weights(y,x)];
            i=i+4;
            ndes(n,:) = [y,x];
            n = n+1;
            
            %make sure we have the indexes to the starting and ending nodes
            if x==startnode(1)
                if y==startnode(2)
                    startn = n;
                end
            end
            if x==endnode(1)
                if y==endnode(2)
                    endn = n;
                end
            end 
        end
        disp(x);
    end
    disp('in dijkstra');
    [costout, pathout] = dijkstra(ndes,edgs,[startn],[endn]);
    
end

