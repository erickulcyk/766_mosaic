function [ minx,miny,maxx,maxy ] = findboundsofmask(mask )
%findboundsofmask
%   Finds and returns the right-most, left-most, top-most, and bottom-most
%   Bounds on the true values in a logical array
	miny = -1;
    maxy = -1;
    for y=1:size(mask,1)
        if sum(mask(y,:))
            if miny == -1
                miny = y;
            end
            maxy = y;
        end
    end
    minx = -1;
    maxx = -1;
    for x=1:size(mask,2)
        if sum(mask(:,x))
            if minx == -1
                minx = x;
            end
            maxx = x;
        end
    end
end

