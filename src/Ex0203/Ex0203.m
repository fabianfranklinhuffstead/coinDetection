%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Title:    Excercise 2.3
%
% Author SID:   1210275
%
% Rev Date: 2015
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;

%originalImage = imread('coins.png'); %Original image used in excersise
originalImage = imread('coins.bmp'); %Photograph taken off my own pocket change

se = strel('disk',2);
bufferedImage = imopen(originalImage, se); % this fills the noise

%Method 1 using im2bw & GreyThresh (otsu)
% normalizedThresholdValue = graythresh(originalImage);
% binaryImage = im2bw(originalImage, normalizedThresholdValue);

%Method 2 using a logical operators (hi pass)
thresholdValue = 100;
binaryImage = bufferedImage > thresholdValue;

binaryImage = imfill (binaryImage,'holes');%fill binary image

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Displays images (uncommment this then comment below start till finish)

% subplot(1,3,1); %example
% imshow(originalImage);title('originalImage');

%Works when normalizedThreshholdValue is switched on
% % subplot(1,3,2); %example
% % imshow(normalizedThresholdValue);title('normalizedThresholdValue');

%
% subplot(1,3,3); %example
%imshow(binaryImage);title('binaryImage');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Start
% (Start of for method for displaying coins seperately)
label = bwlabel(binaryImage);
max(max(label))
im1=(label==1);

% %Shows just 1st and last element
% figure, imshow(im1);
% figure, imshow(label==6);

for i=1:max(max(label))
    
    [row,col]= find(label==i);
    
    length=max(row)-min(row)+2;
    breath=max(col)-min(col)+2;
    
    if (i <= 12) %this is kept at 12 because that is the max coins for this specific excerise
        target=uint8(zeros([length breath]));
        sy=min(col)-1; sx=min(row)-1;
        
        for n=1:size(row,1)
            
            x=row(n,1)-sx;
            y=col(n,1)-sy;
            
            target(x,y)=originalImage(row(n,1), col(n,1));
        end %end for statement
        
        %Display each object with title on its own figure
        subplot(3,4,i);
        imshow(target);
        mytitle = strcat('Object no.  ',num2str(i));
        title(mytitle);
        % Add a Title to Our Image
        
        %%for individual object diplays on seperate figures
        %mytitle = strcat('Object no.  ',num2str(i));
        %figure, imshow(target);
        %title(mytitle);
        
    else
        input('Error in counting objects please make sure there are 12 or less.\n\n Press enter to continue.\n\n'); %simple error message
        return;
    end %end if statement
    
end % %Finish

print -f1 -dbmp -r300 tut02Ex03.bmp %%Screen capture of result

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Code from Excersise.
% subplot(3,1,1); imshow(binaryImage);title('Original');
%
% subplot(3,1,2); imhist(originalImage); hold on;
%
% subplot(3,1,3); imhist(binaryImage); hold on;
% figure;
%
% C = bwconncomp(binaryImage,8);
% disp(['Objects in Image = ' num2str(C.NumObjects)]);
%
% labelled = labelmatrix(C);
% for currentObject = 1:C.NumObjects
%     imshow(labelled==currentObject);
%     title(['Object Number: ' num2str(currentObject) 'of' num2str(C.NumObjects)]);
%     pause(2);
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

