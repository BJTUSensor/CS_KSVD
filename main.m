clear all; close all;
tic;

load KSVD_Dictionary
load KSVD_CoefMatrix
load Phi


%-----------------------生成矩阵--------------------------
f = zeros(126, 10);
for i = 1:10
t = [10.7: 0.004: 11.2];  
v_b = 10.88+0.0004*(i-1);
f(:,i) = 1./(1+4*(((t-v_b)./(0.055)).^2));
bfs_o(i) = v_b;
end

%-----------------------采样并重构--------------------------
for i = 1 : 10
    f2 = (Phi * f(:,i))';                    
    Psi = KSVD_Dictionary;          
    A = Phi * Psi;  
    
    s(:,i) = CS_OMP(f2,A,K);                               
    x_lm(i,:) = KSVD_Dictionary*s(:,i);
end

toc;