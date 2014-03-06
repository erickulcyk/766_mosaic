function [cylinderImg] = ApplyLut(img, lutX, lutY)
maxX = int32(max(max(lutX)));
minX = int32(min(min(lutX)));

minY = int32(min(min(lutY)));
maxY = int32(max(max(lutY)));

sizeX = maxX-minX+2;
sizeY = maxY-minY+2;

cylinderImg = uint8(zeros(sizeY, sizeX));
filled = zeros(sizeY,sizeX);
for i=1:size(img,2)
    x = lutX(i,1)-minX+1;
    for j=1:size(img,1)
        y = lutY(j,i,1)-minY+1;
        if filled(y,x)==0
            for k=1:3
                cylinderImg(y,x,k,1) = img(j,i,k,1);
            end
            filled(y,x) = 1;
        end
    end
end
end