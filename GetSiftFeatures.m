function [ frames, descriptors] = GetSiftFeatures(img)
    run('vlfeat-0.9.18\toolbox\vl_setup');
    img = single(rgb2gray(img));
    [frames, descriptors] = vl_sift(img);
end