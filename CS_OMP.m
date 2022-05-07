function [ s ] = CS_OMP( y, A, k )                     % ����֪y��A���������s   k ϡ���
    [y_rows, y_columns] = size(y);  
    if y_rows < y_columns  
        y = y';                                        % yӦ���Ǹ�������  
    end  
    [M, N] = size(A);                                  % ���о���AΪM*N����  
    s = zeros(N, 1);                                   % �����洢�ָ���s(������)  
    At = zeros(M, k);                                  % �������������д洢A��ѡ�����  
    Pos_s = zeros(1, k);                               % �������������д洢A��ѡ��������  
    r_n = y;                                           % ��ʼ���в�(residual)Ϊy  
    for i = 1 : k                                      % ����k�Σ�kΪ�������ϡ���
        product = A' * r_n;                            % ���о���A������в���ڻ�  M*N x N*1 = M*1 
        [val, pos] = max(abs(product));                % [val, pos]�������ֵ�����ֵ�������ҵ�����ڻ�����ֵ������в�����ص���  
        At(:, i) = A(:, pos);                          % �洢��һ��  
        Pos_s(i) = pos;                                % �洢��һ�е����  
        A(:, pos) = zeros(M, 1);                       % ����A����һ�У���ʵ���п��Բ�Ҫ����Ϊ����в�����  
        %y=At(:,1:ii)*s��������s����С���˽�(Least Square)  
        s_ls = (At(:, 1:i)' * At(:, 1:i))^(-1) * At(:, 1:i)' * y;% ��С���˽�  
        %At(:,1:ii)*theta_ls��y��At(:,1:ii)�пռ��ϵ�����ͶӰ  
        r_n = y - At(:, 1:i) * s_ls;                         % ���²в�          
    end  
    s(Pos_s) = s_ls;                                          % �ָ�����s 
end