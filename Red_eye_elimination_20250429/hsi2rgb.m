function  rgb = hsi2rgb(f)
% 执行从hsi图像到rgb图像的色彩转换
% Jiahao Zhou
% 20250429
f = double(f);
[m,n,l] = size(f);
H = f(:,:,1);
S = f(:,:,2);
I = f(:,:,3);
R = zeros(size(H));
G = zeros(size(H));
B = zeros(size(H));

for i = 1:m
    for j = 1:n
        if (S(i,j))
            if(H(i,j)>=0&H(i,j)<=1/3)
            R(i,j) = I(i,j)*(1+S(i,j)*cos(H(i,j)*2*pi)/(cos((1/6-H(i,j))*2*pi)+eps));
            B(i,j) = I(i,j)*(1-S(i,j));
            G(i,j) = 3*I(i,j)-(R(i,j)+B(i,j));
            elseif(H(i,j)>=1/3&H(i,j)<=2/3)
            H_1 = H-1/3;
            G(i,j) = I(i,j)*(1+S(i,j)*cos(H_1(i,j)*2*pi)/(cos((1/6-H_1(i,j))*2*pi)+eps));
            R(i,j) = I(i,j)*(1-S(i,j));
            B(i,j) = 3*I(i,j)-(R(i,j)+G(i,j));
            else
            H_2 = H-2/3;
            B(i,j) = I(i,j)*(1+S(i,j)*cos(H_2(i,j)*2*pi)/(cos((1/6-H_2(i,j))*2*pi)+eps));
            G(i,j) = I(i,j)*(1-S(i,j));
            R(i,j) = 3*I(i,j)-(B(i,j)+G(i,j));
            end
        else
            R(i,j)=I(i,j);
            G(i,j)=I(i,j);
            B(i,j)=I(i,j);
        end
    end
end
% rgb = cat(3,uit(R),uint8(G),uint8(B));
rgb = cat(3,R,G,B);