function [ cylinderX, cylinderY ] = CylinderImgLut (imgRows, imgColumns, focalLength, rowOffset, colOffset)

centerImgCol = imgColumns/2;
centerImgRow = imgRows/2;
cylinderX=zeros(imgColumns);
cylinderY=zeros(imgRows,imgColumns);

parfor i=1:imgColumns
    cylinderX(i) = focalLength*atan((i-centerImgCol)/focalLength);
    denom = sqrt((i-centerImgCol)*(i-centerImgCol)+focalLength*focalLength);
    for j=1:imgRows
        cylinderY(j,i) = focalLength*(j-centerImgRow)/denom;
    end
end

minX = min(min(cylinderX(:,1)))-1;
minY = min(min(cylinderY))-1;

parfor i=1:imgColumns
    cylinderX(i) = int32(round(cylinderX(i) - minX+colOffset));
    for j=1:imgRows
        cylinderY(j,i) = int32(round(cylinderY(j,i) - minY+rowOffset));
    end
end

disp(['Minimum cylinder x: ',num2str(min(min(cylinderX(:,1))))]);
disp(['Minimum cylinder y: ',num2str(min(min(cylinderY)))]);

imgWidth = max(max(cylinderX))+1;
imgHeight = max(max(cylinderY))+1;
disp(['Maximum cylinder x: ',num2str(imgWidth)]);
disp(['Maximum cylinder y: ',num2str(imgHeight)]);
end