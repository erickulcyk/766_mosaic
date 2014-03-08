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
    weights = ones(dims);
    for i=minx:maxx;
        for j=miny:maxy;
            weights(j,i) = 1+sum(power(img1(j,i,:)-img2(j,i,:),2));
        end
    end
    disp('done with differencing, preparing graph');
    %Create graph for Djikstra
    [V,E3,startn,endn,topn,botn] = buildGraphForGrid(dims,weights,startnode,endnode,topconnect, botconnect);
    
    disp('in dijkstra');
    [costout, pathout] = jkdijkstra(V, E3, [startn], [endn]);
    disp(costout);
    
    disp('stitching images in intersect region');
    %Figure out which image should be placed above the cut line
    %if the cut line has positive slope, the right-up image is on top
    %otherwise, the left-up image is on top 
    connect = topn;
    if poslin 
       if sum(sum(img1def(miny-1,:)),sum(img1def(:,maxx+1)))
          connect = botn;
       end
    else
       if sum(sum(img1def(miny-1,:)),sum(img1def(:,minx-1)))
          connect = botn;
       end
    end
    intr = img1(miny:maxy,minx:maxx,:);
    intr2 = img2(miny:maxy,minx:maxx,:);
    intrmask = repmat(findGridConnectedToPath(V,E3,connect,pathout,dims),[1 1 3]);
    intr(intrmask) = intr2(intrmask);
    spliced = img1;
    spmask = repmat(intsect,[1 1 3]);
    spliced(spmask) = intr;
end

