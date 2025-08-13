%图片的缩小
%20250506
%Jiahao Zhao


%%%%%%%%%%%%%默认为uint8,本程序并未加上格式判断，为防止报错可以加上
% if isa(img, 'uint8')
%     disp('图像是 uint8 格式');
% elseif isa(img, 'uint16')
%     disp('图像是 uint16 格式');
% else
%     disp('图像是其他格式');
% end
%%%%%%%%%%%%%%或
% img = imread('example.jpg');  
% dataType = class(img);        

function zoom_out = shrink(f, dx,dy)
%当形参为(f,c)时，为防止报错，采用nargin(参数数量),默认为等比例缩小即dx ==dy ==c
    if nargin<3&&nargin>=2
        dy = dx;
    elseif isequal(nargin,1)&&isequal(nargin,0)
        disp("请正确输入所需参数");
        zoom_out = zeros(1,1);
        return;
    end
     f = double(f);
    [x, y, z] = size(f);
    
    step_1 = max(1, round(1/dx));  
    step_2 = max(1, round(1/dy));
    
    new_x = ceil(x * dx);
    new_y = ceil(y * dy);
    
    %其实这步多余,like,是为了f与zomm_out的形式一致为double
    %可以简写为zoom_out = zero(new_x,new_y,z)默认为double型
    zoom_out = zeros(new_x, new_y, z, 'like', f);
    
    for i = 1:step_1:x
        for j = 1:step_2:y
            new_i = min(ceil(i * dx), new_x);
            new_j = min(ceil(j * dy), new_y);
            
            zoom_out(new_i, new_j, :) = f(i, j, :);
        end
    end
    
    zoom_out = uint8(zoom_out);
    end
