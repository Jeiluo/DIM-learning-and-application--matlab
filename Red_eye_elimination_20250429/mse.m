function MSE = mse(A,B);
%MSE计算
%Jiahao Zhou
%20250429
[m,n,l] = size(A);
t=1;
for i = 1:m
    for j = 1:n
        t = t*power(A(i,j)-B(i,j),2);
    end
end
MSE = t/(m*n);