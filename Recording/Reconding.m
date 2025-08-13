 %A = zeros(a,b,c);矩阵A先行a*b0矩阵，提高运行速度，为double型
 %A = zeros(a,b,c,'like',B);如果B是uin8型,那么生成的A也是uint8型
 %A = ones(a,b,c)  单位矩阵
 %A = rand(a,b,c) or randn(a,b,c)
 %A = eye(a,b,c)猪对角线为1其余为0
 %当然a=b,以上可以简写为rand(a)
 %若X为矩阵,diag(X)为对=对角向量
 %tril(A) 下三角///triu（A） 上三角
 %%矩阵的运算
 %A+B  A-B A*B
 %A.*B逐元素乘
 %A\B=inv(A)*B
 %A/B=A*inv(B)
 %A./B逐元素相除，为防止B中的元素为0，需要加一个eps
 %A^p乘方
 %A'转置
 %C=A>B,逐元素比较，true为1，false为0
 %%
 %对于一个矩阵A
 %A(a,b,c),c为维度
 %B = A(,,3)第三个维度的二维矩阵
 %A(a,:)表示第a行的所有元素
 %A(:,a)表示第a列的所有元素
 %A(i:i+m,:)表示第i行到第i+m行所有元素
 %A(:,k:k+m)表示第k列到第k+m列所有元素
 %A(1:3:5,2:3:5)表示第一行第四行与第二列第五列的交叉元素
 %%
 %clear 清理工作区
 %clear A x清除指定变量A x
 %clc 清空命令行窗口
 %%
 %a:b:c,a表示起始值,b表示步长，c表示终止值
 %%
 %所有字符串s='sddsgdsgsfgtd'
 %%工作区间的变量存储与读取
 %save 名字.mat  存储所有变量
 %save 名字.mat  A存储指定变量
 %load 名字.mat
 %load 名字.mat  A x y B
 %%c++与matlab   需要在末尾加end
 %if 
 %switch中的default需要改为otherwise
 %for i a:b:c
 %while
 %break continue
 %%命令脚本eg 命名为unti_1
 %新建  脚本
 %右击  智能缩进
 % 命令窗口unti_1运行
 % %函数
 % 新建脚本
 % function f=inv(b)
 % 存储时名字为inv，不可更改
 % 在命令窗口f=inv(15),即可运行
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %im+TAB
 %imread/[A,map,alpha]=imread('名字'),map调色板的颜色数量，alpha图像透明度数据
 %imshow
 %imwrite(A,'名字.后缀名')
 %imtool(文件名）/imtool(A) 图像浏览器
 %imrotate(A,angle,method)method:nearest,bilinear,bicubic
 %imresize(A,scale)
 %%
 %help
 %doc 以网页的形式显示指定命令的帮助页
 %%
 %[filename,pathname]=uigetfile(file_type,dialogtitile)
 %roi = roipoly(A),选择得到的区域将选中的区域赋值为1，其他为0
 %[row,col] = find(A),返回矩阵中的非0元素行号和列号
 %C=cat(dim,A,B),dim=1，A,B上下拼接；dim=2,A,B左右拼接；dim=3,A,B,三维
 %(a,b,c)=size(A),将三位矩阵的信息提取出来
 %min/max(A,B),逐步比较两个矩阵元素的大小
 %ceil(a) == int(a)+1
 %floor(a) == int(a)
 %round(a)四舍五入
 %...换行
 %%
 %对于function的形参,如果形参有多个,而输入的实参数量不足,可以用nargin来判段输入形参的个数
 %%
 %对于矩阵A,[x,y,z] = size(A);
 %[X,Y] = meshgrid(1:x,1:y);将元素的坐标提取出来
 %行,列——>y,x,所以要将X',Y'
 %%灰度,I为灰度图
 %T(f(x,y)) = a*f(x,y) + b;
 %a=1,b>0,图像变亮
 %a=1,b<0,图像变暗
 %a<0,图像明暗关系反转
 %[0,255]~[-255,0],A=-I,(A-min(A))/(max(A)-min(A))*255
 %imadjust(I,[low_in,high_in],[low_out,high_out],gamma]gamma默认为1
 %imadjust(I,stretchlim(I),[low_out,high_out],gamma]
 %gamma =1,线性
 %gamma >1,降低暗部亮度（整体变暗，增强对比度）,亮度细节更清晰
 %gamma <1,提升暗部亮度（整体变亮，适合低对比度图像）,暗部细节更清晰
 %%噪声
 %假如Gi,i = 1:M,被噪声污染的图,将(Gi+....Gm)/M,可以去除一部分噪声
 %比较像图像两个做差,可以看出两张的区别
 %%%%%%%%%%%%图像的几何变换雨其他相关函数
 %T = graythreth(A)一张灰度图的大津阈值，即背景与主题的差异阈值
 %imbinarize(A, T)以这个阈值将图像进行二值化处理
 %imdilate(A,structure),对以图像进行膨胀处理，比如采用圆形句柄strel('disk',3)
 %imerode(A,structure),对图像进行收缩处理雨imdilate相对
 %[B,num] = bwlable(B),对二值化之后的图像进行区域标记，num为区域的个数