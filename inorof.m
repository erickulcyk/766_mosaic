function [ boolout ] = inorof(mask1,mask2,x,y)
%Returns true if x,y is contained in one or both of {mask1, mask2}, 
% returns false otherwise
    boolout = false;
    if mask1(y,x)
        boolout = mask2(y,x);
end

