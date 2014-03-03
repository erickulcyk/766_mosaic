function [ cylinderX, cylinderY ] = CylinderImgLut (imgRows, imgColumns, focalLength, rowOffset, colOffset)

centerImgCol = imgColumns/2;
centerImgRow = imgRows/2;
cylinderX=zeros(imgRows);
cylinderY=zeros(imgRows,imgColumns);

parfor i=1:imgColumns
    cylinderX(i) = focalLength*atan((i-centerImgCol)/focalLength)+colOffset;
    denom = sqrt((i-centerImgCol)*(i-centerImgCol)+focalLength*focalLength);
    for j=1:imgRows
        cylinderY(j,i) = focalLength*(j-centerImgRow)/denom+rowOffset;
    end
end

disp(['Minimum cylinder x: ',num2str(min(min(cylinderX)))]);
disp(['Minimum cylinder y: ',num2str(min(min(cylinderY)))]);

disp(['Maximum cylinder x: ',num2str(max(max(cylinderX)))]);
disp(['Maximum cylinder y: ',num2str(max(max(cylinderY)))]);

end