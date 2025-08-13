%图像质量评价
%Jiahao Zhou
%20250429

[filename,pathname]= uigetfile('*.*',"选取一副标准图像");
x = input("请输入待评价图像数量")

Judged_cell=cell(1,x);
MSE = zeros(1,x);
PSNR = zeros(1,x);

if isequal(filename,0)||isequal(pathname,0)
    disp('取消选择，程序结束')
else
    path = fullfile(pathname,filename);
    image = imread(path);
    [m,n,l] = size(image);

    for i =1:x
        Judged_cell{i} = zeros(m,n);
        [filename_1,pathname_1]= uigetfile('*.*',"选取一副待评价图像");

        if isequal(filename,0)||isequal(pathname,0)
            disp('取消选择，程序结束')
            break;

        else
            path_1 = fullfile(pathname_1,filename_1);
            Judged_cell{i} = imread(path_1);

            MSE(1,i) = sum(sum((image-Judged_cell{i}).^2))/(m*n);
            PSNR(1,i) = 10*log10(255*255/MSE(1,i));

            subplot(1,x,i);
            imshow(Judged_cell{i});
            title(sprintf('MSE=%.4f\nPSNR=%.4f', MSE(1,i), PSNR(1,i)));
        end
    end
end