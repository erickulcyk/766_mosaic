function [ frames, descriptors] = GetSiftFeatures(img)
    run('U:\vlfeat-0.9.18\toolbox\vl_setup');
    img = single(rgb2gray(img));
    [frames, descriptors] = vl_sift(img);
end