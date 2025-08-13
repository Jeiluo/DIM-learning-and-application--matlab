%图片放大
%20250506
%Jiahao Zhou


function zoom_in = enlarge(f,dx,dy)
    if nargin<3&&nargin>=2
        dy = dx;
    elseif isequal(nargin,1)&&isequal(nargin,0)
        disp("请正确输入所需参数");
        zoom_in = zeros(1,1);
        return;
    end

    f = double(f);
    [x,y,z] = size(f);

    % 向上取整保证放大后的尺寸足够
    new_x = ceil(x*dx);
    new_y = ceil(y*dy);

    zoom_in = zeros(new_x,new_y,z,'like',f);

    %%具体解释见------------->---------->----->------->%meshgrid提取矩阵元素的坐标
    [X,Y] = meshgrid(1:new_x,1:new_y);                %meshgrid是列优先，而图像处理是行优先，所以需要转置
                                                      
    X = X';
    Y = Y';

    x_old = X/dx;
    y_old = Y/dy;

    x_1 = floor(x_old);
    y_1 = floor(y_old);
    %%边界检查
    % 确保x_2不超过原始图像宽度x
    x_2 = min(x_1+1,x);
    % 确保y_2不超过原始图像高度y
    y_2 = min(y_1+1,y);
    
    %%下限保护
    % 确保x_1，y_1不小于1
    x_1 = max(x_1,1);
    y_1 = max(y_1,1);

    for k = 1:z
        %f(x,y,z) == f(m),index
        Q11 = f(x_1 + (y_1-1)*x + (k-1)*x*y);
        Q21 = f(x_2 + (y_1-1)*x + (k-1)*x*y);
        Q12 = f(x_1 + (y_2-1)*x + (k-1)*x*y);
        Q22 = f(x_2 + (y_2-1)*x + (k-1)*x*y);

        zoom_in(:,:,k) = (1-(y_old - y_1)) .* ( (1-(x_old - x_1)).*Q11 + (x_old - x_1).*Q21 )...
            +(y_old - y_1).*((1-(x_old - x_1)).*Q12 + (x_old - x_1).*Q22);
    end
    
    zoom_in = uint8(zoom_in);