function croppedImg = CropMosaic(mosaicImg)
rows = size(mosaicImg,1);
cols = size(mosaicImg,2);
    minX = 1;
    maxX = cols;
    minY = 1;
    maxY = rows;
    
    denom = 2;
    
    for i = 100:cols-100
        j = 1;
        while j<rows/denom && sum(mosaicImg(j,i,:))<4
            j = j+1;
        end
        
        if j<rows/denom
            minY = max(minY, j);
        end
        
        j = rows-1;
        while j>(rows*(denom-1))/denom && sum(mosaicImg(j,i,:))<4
            j = j-1;
        end
 
        if j>(rows*(denom-1))/denom
            maxY = min(maxY,j);
        end
    end
    
    for i = minY:maxY
        j = 1;
        while j<cols/denom && sum(mosaicImg(i,j,:))<4
            j = j+1;
        end
        
        if j<cols/denom
            minX = max(minX, j);
        end
        
        j = cols-1;
        while j>(cols*(denom-1))/denom && sum(mosaicImg(i,j,:))<4
            j = j-1;
        end
        
        if j>(cols*(denom-1))/denom
            maxX = min(maxX,j);
        end
    end
    
    disp(['Crop Found Minx MaxX, minY, maxY: ',num2str(minX),' ',num2str(maxX),' ', num2str(minY),' ',num2str(maxY)]);
    
    croppedImg = imcrop(mosaicImg,[minX, minY, maxX-minX, maxY-minY]);
end