function [ spliced, spmask,intrmask,pathout ] = imdijkstra(img1,img2)
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
    dims = [maxy-miny+1,maxx-minx+1]; %dimensions of intersecting region
    
    % Determine at which corners we want to start and end our path
    poslin = false; %whether the average slope of our cut line is positive
    if ((minx==1 && miny==1) || inorof(img1def,img2def,minx-1,miny-1))
        startnode = [dims(1),1];
        endnode = [1,dims(2)];
        topconnect = [1,1];
        botconnect = dims;
    else
        startnode = [1,1];
        endnode = dims;
        topconnect = [1,dims(2)];
        botconnect = [dims(1),1];
        poslin = true;
    end
    
    disp('found intersect, computing differences');
    %fill in parts which are only defined in one image with that value
    for i=1:size(img1,2)
        for j=1:size(img1,1)
            %Want to maximize total output, fill in undefined regions
            if(~img1def(j,i))
                img1(j,i,:) = img2(j,i,:);
            end
            if(~img2def(j,i))
                img2(j,i,:) = img1(j,i,:);
            end
        end
    end        
    
    %find difference on intersect region -- this is our weighting function
    weights = zeros(dims);
    cweights = zeros(ceil(dims/10));
    ccounts = zeros(ceil(dims/10));
    for i=1:dims(2);
       for j=1:dims(1);
          weights(j,i) = 1+sum(power(img1(j,i,:)-img2(j,i,:),2));
          cweights(ceil(j/10),ceil(i/10)) = cweights(ceil(j/10),ceil(i/10))+weights(j,i);
          ccounts(ceil(j/10),ceil(i/10)) = ccounts(ceil(j/10),ceil(i/10))+1;
       end
    end
    cweights = cweights./ccounts + ones(size(cweights));
    disp('done with differencing, preparing graph');
    
    disp(dims);
    %Create graph for Djikstra
    [V,E3full,startn,endn,topn,botn] = buildGraphForGrid(dims,weights,startnode,endnode,topconnect, botconnect);
    [cV,cE3,cstn,cndn,~,~] = buildGraphForGrid(ceil(dims/10),cweights,ceil(startnode/10),ceil(endnode/10),ceil(topconnect/10),ceil(botconnect/10));
    disp(size(V));
    
    disp('Coarse grid: in dijkstra');
    [ccost, cpath] = jkdijkstra(cV, cE3, [cstn], [cndn]);
    disp(ccost);
    
    disp('Refining grid using computed path');
    %make new edges list for interconnect within and between blocks
    %that lie on cpath
    [V,E3] = buildUpGridOnPath(V,cV,weights,cpath,dims);
    
    disp('Fine grid: in dijkstra');
    [costout, pathout] = jkdijkstra(V, E3, [startn], [endn]);
    disp(costout);
    
    disp('stitching images in intersect region');
    %Figure out which image should be placed above the cut line
    %if the cut line has positive slope, the right-up image is on top
    %otherwise, the left-up image is on top 
    connect = topn;
    if poslin 
       if sum([sum(img1def(miny-1,:)),sum(img1def(:,maxx+1))])
          connect = botn;
       end
    else
       if sum([sum(img1def(miny-1,:)),sum(img1def(:,minx-1))])
          connect = botn;
       end
    end
    intr = img1(miny:maxy,minx:maxx,:);
    intr2 = img2(miny:maxy,minx:maxx,:);
    intrmask = findGridConnectedToPath(V,E3full,connect,pathout,dims);
    intrmask = blurMask(intrmask,poslin);
    for i=1:size(intr,1)
       for j=1:size(intr,2)
          intr(i,j,:) = intr(i,j,:)*(1-intrmask(i,j)) + intr2(i,j,:)*intrmask(i,j);
       end
    end
    spliced = img1;
    spliced(miny:maxy,minx:maxx,:) = intr;
end

