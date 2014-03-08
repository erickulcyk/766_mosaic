function lWarped = LinearWarp(mosaicImg)
rows = size(mosaicImg,1);
cols = size(mosaicImg,2);

firstColorLeft = rows;
c = 1;
while c<cols && firstColorLeft < rows
    i = 1;
    while i<rows && (mosaicImg(i,c,1) > 0 || mosaicImg(i,c,2) > 0 || mosaicImg(i,c,3) > 0)
        i= i+1;
    end
    c = c+1;
    firstColorLeft = i;
end

firstColorRight = rows;
c = cols;
while c>1 && firstColorRight < rows
    i = 1;
    while i<rows && (mosaicImg(i,c,1) > 0 || mosaicImg(i,c,2) > 0 || mosaicImg(i,c,3) > 0)
        i= i+1;
    end
    c = c-1;
    firstColorRight = i;
end

shiftUp = firstColorLeft - firstColorRight;
lWarped = zeros(rows-shiftUp,cols, 3);
for i=1:rows-shiftUp
    for j=1:cols)
        shift = int32(shiftUp*(1-double(j)/cols));
        lWarped(i,j,1) = mosaicImg(i+shift,j,1);
        lWarped(i,j,1) = mosaicImg(i+shift,j,2);
        lWarped(i,j,1) = mosaicImg(i+shift,j,3);
    end
end

end