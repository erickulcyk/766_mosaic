function [path, mask] = SimplePath(start,endN, dims, posLin, connect)
sindex = (start(2)-1)*dims(1)+start(1);
eindex = (endN(2)-1)*dims(1)+endN(1);

path = zeros(dims(1)+dims(2)-1,1);
mask = false(dims(1),dims(2));
ind = 1;
path(ind) = sindex;
current = sindex;
right = 1;
height = dims(1,1);
if posLin
    r = 1;
else
    r = height;
end
c = 1;
while current ~= eindex
    ind = ind+1;        
    if posLin
        if (right==1 && current+height <=eindex) || (mod(current-1,height) ==height-1)
            right = 0;
            c = c+1;
            current = current + height;
            for i=1:r
                mask(i,c)= true;
            end
                else
            r = r+1;
            right = 1;
            current = current +1;
        end
    else
        if (right==1 && current+height <=eindex) || (mod(current-1,height) ==0)
            right = 0;
            c = c+1;
            current = current + height;
            for i=1:r
                mask(i,c)= true;
            end
        else
            r = r-1;
            right = 1;
            current = current -1;
        end
    end
    path(ind,1) = current;
end

if mask(connect(1),connect(2)) == false
    mask = ~mask;
end
end