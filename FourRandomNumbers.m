function [ pts ] = FourRandomNumbers(fcount)

pts = zeros(4);

pts(1) = random('unid',fcount);
pts(2)=pts(1);
while pts(2)==pts(1)
    pts(2) = random('unid',fcount);
end

pts(3) = pts(1);
while pts(3)==pts(1) || pts(3) == pts(2)
    pts(3) = random('unid',fcount);
end

pts(4) = pts(1);
while pts(4) == pts(1) || pts(4) == pts(2) || pts(4)== pts(3)
    pts(4) = random('unid',fcount);
end
end