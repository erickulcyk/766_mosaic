function [cImage] = ToCylinderImage(cylinderX, cylinderY, img)
imgWidth = max(max(cylinderX))+1;
imgHeight = max(max(cylinderY))+1;
cImage = uint8(255*zeros(imgHeight,imgWidth, 3));
imgRows = size(img,1);
imgColumns = size(img,2);
for i=1:imgColumns    
    for j=1:imgRows
        cImage(cylinderY(j,i,1), cylinderX(i,1),:) = img(j,i,:,1);
    end
end
end