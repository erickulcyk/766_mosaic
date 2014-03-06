% Combine two images together using a specified transform matrix and a vertical .
function [ mosaicImg ] = Cut2Images ( transform, img1, img2 )
rows = size(img1,1);
cols = size(img1,2);
toMult = zeros(3,rows*cols);

ind = 1;
for i=1:rows
    for j=1:cols
        toMult(:,ind) = [i;j;1];
        ind = ind+1;
    end
end

disp('Done contructing coordinate matrix');
newCoord = int32(transform*toMult);

i2r = size(img2, 1);
i2c = size(img2, 2);

maxX = int32(max(max(newCoord(2,:))));
minX = int32(min(min(newCoord(2,:))));

maxX = max([maxX, i2c]);
minX = min([minX, 1]);

minY = int32(min(min(newCoord(1,:))));
maxY = int32(max(max(newCoord(1,:))));

maxY = max([maxY, i2r]);
minY = min([minY, 1]);

sizeX = maxX-minX+1;
sizeY = maxY-minY+1;

mosaicImg1 = uint8(255*zeros(sizeY,sizeX,3));
mosaicImg2 = uint8(255*zeros(sizeY,sizeX,3));

disp('Done constructing canvas');

r = 1;
c = 1;

for ind=1:rows*cols
    x = newCoord(2,ind)-minX+1;
    y = newCoord(1,ind)-minY+1;
    
    if c == cols+1
        r = r+1;
        c = 1;
    end
    
    for l=1:3
        mosaicImg1(y,x,l,1) = img1(r,c,l);
    end
    
    c = c+1;
end

disp('Done with first image');

for r = 1:i2r
    for c = 1:i2c
        y = r-minY+1;
        x = c-minX+1;
        for l=1:3
            mosaicImg2(y,x,l,1) = img2(r,c,l,1);
        end
    end
end

disp('Done with second image');

mosaicImg = Dijkstras(mosaicImg1,mosaicImg2);
end
