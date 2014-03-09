function lWarped = LinearWarp(mosaicImg)
rows = size(mosaicImg,1);
cols = size(mosaicImg,2);

firstColorLeft = rows;
c = 100;
while c<cols-100 && firstColorLeft < rows/2
    i = 1;
    while i<rows/2 && (mosaicImg(i,c,1) == 0 && mosaicImg(i,c,2) == 0 && mosaicImg(i,c,3) == 0)
        i= i+1;
    end
    c = c+1;
    firstColorLeft = i;
end

firstColorRight = rows;
c = cols-100;
while c>100 && firstColorRight < rows/2
    i = 1;
    while i<rows/2 && (mosaicImg(i,c,1) == 0 && mosaicImg(i,c,2) == 0 && mosaicImg(i,c,3) == 0)
        i= i+1;
    end
    c = c-1;
    firstColorRight = i;
end

shiftUp = firstColorLeft - firstColorRight;
disp(['Found Left: ',num2str(firstColorLeft), ' Right: ', num2str(firstColorRight), ' shift: ', num2str(shiftUp)]);
lWarped = uint8(zeros(rows-shiftUp,cols, 3));
for i=min(1,-shiftUp+1):rows-shiftUp
    for j=1:cols
        shift = int32(shiftUp*(1-double(j)/cols));
        lWarped(i,j,1) = mosaicImg(i+shift,j,1);
        lWarped(i,j,2) = mosaicImg(i+shift,j,2);
        lWarped(i,j,3) = mosaicImg(i+shift,j,3);
    end
end

end