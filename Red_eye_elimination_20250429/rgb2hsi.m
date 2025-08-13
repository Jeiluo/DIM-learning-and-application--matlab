function  hsi = rgb2hsi(f)
% 执行从rgb图像到hsi图像的色彩转换
% Tao
% 2014/10/10
f = double(f);
[m,n,l] = size(f);
R = f(:,:,1);
G = f(:,:,2);
B = f(:,:,3);
I = (R+G+B)/3;
temp = min(min(R,G),B);
S = 1 - 3*temp./(R+G+B+eps);
temp = ((R-G) + (R-B))/2;
den = sqrt((R-G).*(R-G)+(R-B).*(G-B));
theta = acos(temp./(den+eps));
H = theta;
H(B>G) = 2*pi - H(B>G);
for i = 1:m
   for j = 1:n
      if(B(i,j)>G(i,j))
         H(i,j) = 2*pi - theta(i,j);
      else
         H(i,j) = theta(i,j);
      end
   end
end
H = H/(2*pi);
hsi = cat(3,H,S,I);
%Jiahao Zhou
%20250429修改