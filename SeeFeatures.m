function []=SeeFeatures(img1, img2, features1, features2, descriptors1, descriptors2, numFeatures)
figure;
imshow(img1);

sel = 1:numFeatures;
sel2 = 1:numFeatures;
h1 = vl_plotframe(features1(:,sel)) ;
h2 = vl_plotframe(features1(:,sel)) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;
h3 = vl_plotsiftdescriptor(descriptors1(:,sel),features1(:,sel)) ;
set(h3,'color','g') ;

a = descriptors1(:,sel(1));
aa = features1(:,sel(1));

b = descriptors2(:,sel2(1));
bb = features2(:,sel2(1));

figure;
imshow(img2);
h1 = vl_plotframe(features2(:,sel2)) ;
h2 = vl_plotframe(features2(:,sel2)) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;
h3 = vl_plotsiftdescriptor(descriptors2(:,sel2),features2(:,sel2)) ;
set(h3,'color','g') ;


end