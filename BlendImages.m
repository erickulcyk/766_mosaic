function [ mosaicImg ] = BlendImages ( imgsX, imgY, imgsRGB )
    maxX = int32(max(max(max(imgsX))));
    minX = int32(min(min(min(imgsX))));
    
    minY = int32(min(min(min(imgsY))));
    maxY = int32(max(max(max(imgsY))));
    
    sizeX = maxX-minX+2;
    sizeY = maxY-minY+2;
    
    mosaicImg = zeros(sizeX,sizeY,3);
    for i=1:size(imgsRGB,1)
        for j=1:size(imgsRGB,2)
            for k=1:size(imgsRGB,3)
                x = int32(imgsX(i,j,1))-minX+2;
                y = int32(imgsY(i,j,k,1))-minY+2;
                mosaicImg(x,y,:) = imgsRGB(i,x,y,:);
            end
        end
    end
end