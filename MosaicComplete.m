% Mosaic Complete
% builds a mosaic using several images with a predefined name format
% (1-1.jpg, 2-1.jpg,etc...), and the number of images you want to combine.
% Returns the complete image, as well as the cropped version.
%'u:\workspace\766_mosaic\capitalImages\'
function [mosaicImg, croppedImg] = MosaicComplete (folder, numImgs, blend)
    mnames = buildMosaicNames(folder, 1, numImgs, 1); % generate name list
    [ imgs,  fLength, expTime] = setupMosaic(mnames, 1, 4750); % read in images
    rows = size(imgs,2);
    cols = size(imgs,3);
    [ cylinderX, cylinderY ] = CylinderImgLut (rows, cols, fLength(1), 0,0); % generate cylinder image look up table
    
    img1 = squeeze(imgs(1,:,:,:));
    mosaicImg = ToCylinderImage(cylinderX, cylinderY, img1); % convert first image to cylinder
    imshow(img1);

    for i=2:size(imgs,1)
        otherImg = squeeze(imgs(i,:,:,:));
        otherCylImg = ToCylinderImage(cylinderX, cylinderY, otherImg); %convert next image to cylinder
        
        w1 = mosaicImg;
        w2 = otherCylImg;
        
        [features1, descriptors1] = GetSiftFeatures(w1); %Compute SIFT features for both images.
        [features2, descriptors2] = GetSiftFeatures(w2);
        
        [matchScore, matchFeatures1, matchFeatures2, matchDescriptors1, matchDescriptors2] = MatchSiftImages (features1, features2, descriptors1, descriptors2, 5); % find matches, threshold = 5.
        numM = size(matchScore,2);
        
        [transform] = RANSAC(matchFeatures1(:,1:numM), matchFeatures2(:,1:numM), 10, 5000,1); % find the best transformation
        if blend==1
            [mosaicImg]=Blend2Images(transform,w1, w2, 50); %combine the two images and blend them together.
        else
            mosaicImg = Cut2Images(transform, w1,w2);
        end
        figure;
        imshow(mosaicImg); % show the combined image.
    end
    
    croppedImg = CropMosaic(mosaicImg);
end
