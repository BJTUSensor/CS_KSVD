function [ s ] = CS_OMP( y, A, k )                     % 在已知y，A的情况下求s   k 稀疏度
    [y_rows, y_columns] = size(y);  
    if y_rows < y_columns  
        y = y';                                        % y应该是个列向量  
    end  
    [M, N] = size(A);                                  % 传感矩阵A为M*N矩阵  
    s = zeros(N, 1);                                   % 用来存储恢复的s(列向量)  
    At = zeros(M, k);                                  % 用来迭代过程中存储A被选择的列  
    Pos_s = zeros(1, k);                               % 用来迭代过程中存储A被选择的列序号  
    r_n = y;                                           % 初始化残差(residual)为y  
    for i = 1 : k                                      % 迭代k次，k为输入参数稀疏度
        product = A' * r_n;                            % 传感矩阵A各列与残差的内积  M*N x N*1 = M*1 
        [val, pos] = max(abs(product));                % [val, pos]返回最大值和最大值索引，找到最大内积绝对值，即与残差最相关的列  
        At(:, i) = A(:, pos);                          % 存储这一列  
        Pos_s(i) = pos;                                % 存储这一列的序号  
        A(:, pos) = zeros(M, 1);                       % 清零A的这一列，其实此行可以不要，因为它与残差正交  
        %y=At(:,1:ii)*s，以下求s的最小二乘解(Least Square)  
        s_ls = (At(:, 1:i)' * At(:, 1:i))^(-1) * At(:, 1:i)' * y;% 最小二乘解  
        %At(:,1:ii)*theta_ls是y在At(:,1:ii)列空间上的正交投影  
        r_n = y - At(:, 1:i) * s_ls;                         % 更新残差          
    end  
    s(Pos_s) = s_ls;                                          % 恢复出的s 
end