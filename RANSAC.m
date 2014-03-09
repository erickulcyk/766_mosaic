function [bestTransform] = RANSAC( feature1, feature2, epsilon, iter, onlyTranslation)
f1count = size(feature1, 2);
f2count = size(feature2, 2);
if f1count<4 || f2count < 4
    disp('Not enough features to do ransac');
end

i = 1;
bestInliers = 0;
A = zeros(8,8);
b = zeros(8);
bestTransform = 0;
while i<iter
    i= i+1;
    if mod(i,10)==0 
        disp(i)
        disp(['Best: ',num2str(bestInliers)])
    end
    
    %Compute Pairs
    [ pts1 ] = FourRandomNumbers(f1count);
    if onlyTranslation==0
        % Compute Homography
        for j =1:4
            A(j,1) = int32(feature1(1,pts1(j)));
            A(j,2) = int32(feature1(2,pts1(j)));
            A(j,3) = 1;
            
            A(j,4) = 0;
            A(j,5) = 0;
            A(j,6) = 0;
            
            A(j,7) = -int32(feature2(1,pts1(j))) * int32(feature1(1,pts1(j)));
            A(j,8) = -int32(feature2(1,pts1(j))) * int32(feature1(2,pts1(j)));
            
            b(j) = int32(feature2(1,pts1(j)));
        end
        
        for j =1:4
            A(j+4,1) = 0;
            A(j+4,2) = 0;
            A(j+4,3) = 0;
            
            A(j+4,4) = int32(feature1(1,pts1(j)));
            A(j+4,5) = int32(feature1(2,pts1(j)));
            A(j+4,6) = 1;
            
            A(j+4,7) = -int32(feature2(2,pts1(j))) * int32(feature1(1,pts1(j)));
            A(j+4,8) = -int32(feature2(2,pts1(j))) * int32(feature1(2,pts1(j)));
            
            b(j+4) = int32(feature2(2,pts1(j)));
        end
        
        h = A\b;
        %Check Points
        H = zeros(3,3);
        H(1,1) = h(1);
        H(1,2) = h(2);
        H(1,3) = h(3);
        H(2,1) = h(4);
        H(2,2) = h(5);
        H(2,3) = h(6);
        H(3,1) = h(7);
        H(3,2) = h(8);
        H(3,3) = 1;
        
    else
        
        H = zeros(3,3);
        H(1,1) = 1;
        H(1,2) = 0;
        H(1,3) = feature2(1,pts1(1))-feature1(1,pts1(1));
        H(2,1) = 0;
        H(2,2) = 1;
        H(2,3) = feature2(2,pts1(1))-feature1(2,pts1(1));
        H(3,1) = 0;
        H(3,2) = 0;
        H(3,3) = 1;
        
    end

    inliers = 0;
    for j=1:size(feature1,2)
        pt = [feature1(1:2,j);1];
        opt = H*pt;
        img2Pt = int32(round(opt/opt(3)));
        dist = (img2Pt(1)-feature2(1,j))^2 + (img2Pt(2)-feature2(2,j))^2;
        if dist<epsilon
            inliers = inliers + 1;
        end
    end
    
    if inliers>bestInliers
        bestInliers = inliers;
        bestTransform = H;
        disp('bestTransform: ');
        disp(bestTransform);
    end
end
tmp = bestTransform(1,3);
bestTransform(1,3) = bestTransform(2,3);
bestTransform(2,3) = tmp;

tmp = bestTransform(1,2);
bestTransform(1,2) = bestTransform(2,1);
bestTransform(2,1) = tmp;

tmp = bestTransform(1,1);
bestTransform(1,1) = bestTransform(2,2);
bestTransform(2,2) = tmp;

disp('bestTransform: ');
disp(bestTransform);
end