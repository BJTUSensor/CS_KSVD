tic
clear all; close all;

for i = 1:1501
n = 126;
t = [10.7: 0.004: 11.2];  
v_b = 10.85+0.0001*(i-1);
f(:,i) = 1./(1+4*(((t-v_b)./(0.055)).^2));
bfs_n(i) = v_b;
end

param.L =  3;    % number of elements in each linear combination.
param.K = 180;    % number of dictionary elements
param.numIteration = 30;   % number of iteration to execute the K-SVD algorithm.

param.errorFlag = 0; % decompose signals until a certain error is reached. do not use fix number of coefficients.
%param.errorGoal = sigma;
param.preserveDCAtom = 0;

%%%%%%% creating the data to train on %%%%%%%%
N = 1501; % number of signals to generate
n = 126;   % dimension of each data
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% initial dictionary: Dictionary elements %%%%%%%%
param.InitializationMethod =  'DataElements';

param.displayProgress = 1;
disp('Starting to  train the dictionary');

[Dictionary,output]  = KSVD(f,param);
KSVD_Dictionary = Dictionary;
KSVD_CoefMatrix = output.CoefMatrix;

toc