%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Title:    Exercise 8.1
%
% Author SID:   1210275
%
% Rev Date: 2015
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;                    % Clear all existing variables from memory

close all;                    % Close any open figures

clc;                          % Clear the Command Window

[fileName, pathName] = uigetfile('*.bmp');% Present the file open dialog box

myImage  = imread([pathName fileName]);  % Load the file who's name is in fileName

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%STREL

choiceStrel = menu('Choose Structuring Element:','Disk','Diamond','Line');
strelSize= input('Enter Size of structuring element: \n');

switch choiceStrel
    case 1
        se = strel('disk', strelSize);
    case 2
        se = strel('diamond', strelSize); %must be a nonnegative integer scalar
    case 3
        strelSizeAngle= input('Enter the angle (in degrees) the structuring element: ');%(measured in a counterclockwise direction from the horizontal axis.
        se = strel('line', strelSize,strelSizeAngle);
    otherwise
        input('Error please press enter.');
        return;
end

%MORPHOLOGICAL

choiceMorph = menu('Choose Morphological operation:','Erode','Dilate','Open','Close');
T         = input('Enter Threshold level (0 to 1): \n'); %Threshold value
binaryImage = im2bw(myImage,T); %black and white image with chosen Threshold Value

switch choiceMorph
    case 1
        maskImage = uint8(imerode(binaryImage, se));  % Create Binary Mask Image for 'Erosion'
    case 2
        maskImage = uint8(imdilate(binaryImage, se)); % Create Binary Mask Image for 'Dilate'
    case 3
        maskImage = uint8(imopen(binaryImage, se));   % Create Binary Mask Image for 'Open'
    case 4
        maskImage = uint8(imclose(binaryImage, se)); % Create Binary Mask Image for 'Close'
    otherwise
        input('Error please press enter.');
        return;
end

outImage  = maskImage.*myImage; %output image

bwImage = im2bw(outImage); %black and white out Image


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Original Image
subplot(1,4,1);
imshow(myImage);
title('Original')

%Binary Threshhold
subplot(1,4,2);
imshow(binaryImage);
title('Binary T Image')

%BW image
subplot(1,4,3);
imshow(bwImage);
title('B&W Out Image')

%Output standard image
subplot(1,4,4);
imshow(outImage);
title('Out Image')


print -f1 -dbmp -r300 tut08Ex01.bmp %Screen capture of result depending on
%what the user selects output will be different


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%NOTES%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%use the im2bw function shown in lecture 01 to crate a binary image from a
%user specified image, (the user can select using uigetfile) and threshold,
%T. Test the program using coins.bmp

%enable erode, dilate, open, close






