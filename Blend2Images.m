% Combine two images together using a specified transform matrix and a vertical .
function [ mosaicImg ] = Blend2Images ( transform, img1, img2, blendWidth )
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

if minX>=0
    shift = -1.0;
    blendLine = (i2c+minX)/2;
    disp('Setting blend line to: ');
    i2c
    minX
    blendLine
else
    shift = 1.0;
    blendLine = (1+maxX)/2;
    disp('else Setting blend line to: ');
    1
    maxX
    blendLine
end

maxX = max([maxX, i2c]);
minX = min([minX, 1]);

minY = int32(min(min(newCoord(1,:))));
maxY = int32(max(max(newCoord(1,:))));

maxY = max([maxY, i2r]);
minY = min([minY, 1]);

sizeX = maxX-minX+1;
sizeY = maxY-minY+1;

mosaicImg = uint8(255*zeros(sizeY,sizeX,3));
weightTotal = zeros(sizeY,sizeX);
size(mosaicImg)

disp('Done constructing canvas');

r = 1;
c = 1;

blendLine = blendLine - minX + 1;

for ind=1:rows*cols
    x = newCoord(2,ind)-minX+1;
    y = newCoord(1,ind)-minY+1;
    
    if c == cols+1
        r = r+1;
        c = 1;
    end
    
    if shift*(blendLine-x) >= blendWidth
        for l=1:3
            mosaicImg(y,x,l,1) = img1(r,c,l);
            weightTotal(y,x) = 1;
        end
    else
        if abs(x-blendLine)<blendWidth && weightTotal(y,x)<1
            percent = shift*double(blendLine-x)/2.0/double(blendWidth)+.5;
            percent = min(percent,1-weightTotal(y,x));
            weightTotal(y,x) = weightTotal(y,x)+percent;
            for l=1:3
                mosaicImg(y,x,l,1) = mosaicImg(y,x,l,1)+uint8(double(img1(r,c,l))*percent);
            end
        end
    end
    
    c = c+1;
end

disp('Done with first image');

for r = 1:i2r
    for c = 1:i2c
        y = r-minY+1;
        x = c-minX+1;
        if shift*(x-blendLine) >=blendWidth
            for l=1:3
                mosaicImg(y,x,l,1) = img2(r,c,l,1);
                weightTotal(y,x) = 1;
            end
        else
            if abs(x-blendLine)<blendWidth && weightTotal(y,x)<1
                percent = shift*double(x-blendLine)/2.0/double(blendWidth)+.5;
                percent = min(percent,1-weightTotal(y,x));
                weightTotal(y,x) = weightTotal(y,x)+percent;
                for l=1:3
                    mosaicImg(y,x,l,1) = mosaicImg(y,x,l,1)+uint8(double(img2(r,c,l,1))*percent);
                end
            end
        end
    end
end
