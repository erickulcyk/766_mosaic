function [matchScore, matchFeatures1, matchFeatures2, matchDescriptors1, matchDescriptors2] = MatchSiftImages (features1, features2, descriptors1, descriptors2, threshold)
[matches, scores] = vl_ubcmatch(descriptors1, descriptors2, threshold);
matchScore = transpose(sortrows([transpose(matches),transpose(scores)],3));
matchFeatures1 = features1(:, squeeze(matchScore(1,:)));
matchFeatures2 = features2(:, squeeze(matchScore(2,:)));
matchDescriptors1 = descriptors1(:, squeeze(matchScore(1,:)));
matchDescriptors2 = descriptors2(:, squeeze(matchScore(2,:)));
end