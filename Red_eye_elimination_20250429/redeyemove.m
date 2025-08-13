%红眼消除
%Jiahao Zhou
%20250429
%%
[filename,pathname]= uigetfile('*.*',"选取一副图像");
if isequal(filename,0)||isequal(pathname,0)
    disp('取消选择，程序结束')
    return;
else 
    path = fullfile(pathname,filename);
    image = imread(path);

    figure,roi_1 = roipoly(image);
    figure,roi_2 = roipoly(image);
    [row_1,col_1] = find(roi_1);
    [row_2,col_2] = find(roi_2);

    hsi_image = rgb2hsi(image);
    [m,n,l] = size(hsi_image);

    H = hsi_image(:,:,1);
    S = hsi_image(:,:,2);
    I = hsi_image(:,:,3);

    for i = 1:m
        for j = 1:n
            if (ismember(i,row_1)&&ismember(j,col_1))||(ismember(i,row_2)&&ismember(j,col_2))
                if (((H(i,j)>=0&H(i,j)<=0.1)|(H(i,j)>=0.9&H(i,j)<=1))&(S(i,j)>=0.2))
                    S(i,j)=0;
                end
            end
        end
    end
    
    hsi_image_1 = cat(3,H,S,I);
    fixed_image = hsi2rgb(hsi_image_1);

    subplot(1,2,1);
    title("原图");
    imshow(image);
    subplot(1,2,2);
    title("修改后");
    imshow(uint8(fixed_image));
end