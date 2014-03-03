%basedir - '/path/to/directory/containing/files/'
%outputs an array of shots starting at shotNumber and going to
%shotNumber+numberOfShots using image imgNumber
function fnames = buildMosaicNames(basedir,shotNumber,numberOfShots, imgNumber)
    for i = shotNumber:shotNumber+numberOfShots
        fnames{i} = [basedir, num2str(i), '-', num2str(imgNumber), '.jpg'];
    end
end