% Takes in cell array of j filenames corresponding to aligned set of images

function [ imgs,  fLength, expTime] = setupMosaic(fnames)
    assert(iscellstr(fnames), 'Error: fnames must be a cell array of filename strings');
     
    imgcount = numel(fnames);
    oneImg = imread(fnames{1});
    rows = size(oneImg,1);
    columns = size(oneImg,2);
    channels = size(oneImg,3);
    imgs = uint8(zeros(imgcount,rows,columns,channels));
    fLength = zeros(imgcount);
    expTime = zeros(imgcount);
    size(imgs);
    i = 1;
    while i<=numel(fnames)
        img = imread(fnames{i});
        imgs(i,:,:,:) = img;
        % set up T(i) based on image metadata (exif tag)
        info = imfinfo(fnames{i});
        %try
            expTime(i) = info.DigitalCamera.ExposureTime;
            fLength(i) = 663;%663 is the focal length in pixels for the a640 %info.DigitalCamera.FocalLength*info.XResolution/2.54;
            disp(info.ResolutionUnit);
        %catch err
       %    print('Could not find exposure time or focal length for an image');
       % end
        
        %Next image
        i = i+1;
    end    
end