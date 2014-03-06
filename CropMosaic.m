function croppedImg = CropMosaic(mosaicImg)
rows = size(mosaicImg,1);
cols = size(mosaicImg,2);
    minX = 1;
    maxX = cols;
    minY = 1;
    maxY = rows;
    
    for i = 1:cols
        j = 1;
        while j<rows && mosaicImg(j,i,1)==0 && mosaicImg(j,i,2)==0 && mosaicImg(j,i,3)==0
            j = j+1;
        end
        
        if j<rows
            minY = max(minY, j);
        end
        
        j = rows-1;
        while j>0 && mosaicImg(j,i,1)==0 && mosaicImg(j,i,2)==0 && mosaicImg(j,i,3)==0
            j = j-1;
        end
        
        if j>1
            maxY = min(maxY,j);
        end
    end
    
    for i = minY:maxY
        j = 1;
        while j<cols && mosaicImg(i,j,1)==0 && mosaicImg(i,j,2)==0 && mosaicImg(i,j,3)==0
            j = j+1;
        end
        
        if j<cols
            minX = max(minX, j);
        end
        
        j = cols-1;
        while j>0 && mosaicImg(i,j,1)==0 && mosaicImg(i,j,2)==0 && mosaicImg(i,j,3)==0
            j = j-1;
        end
        
        if j>1
            maxX = min(maxX,j);
        end
    end
    
    croppedImg = imcrop(mosaicImg,[minX, minY, maxX-minX, maxY-minY]);
end