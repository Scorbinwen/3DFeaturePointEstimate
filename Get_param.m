
function [A_new] = Get_param(d,mat_a)
%% Get the param A

% mat_a [a mx3 matix]
% d_i is the target of i-th example.[d is a mx1 column vector].
%% Global variables
eps = 1e-7;
alpha = 0.001;
%% Precomputed Variables
m = size(mat_a,1);
vec_da = sum(d.*mat_a,1);
mat_aa = zeros(3,3);
for i=1:m
    mat_aa = mat_aa + mat_a(i,:)'*mat_a(i,:);
end
scalar_dd = d'*d;
vec_ad = vec_da';

% Initialization 
A_old =[1,0,1];
start = 1;
f_A_new = eps+1;
f_A_old = 0;

while(start || abs(f_A_new-f_A_old)>eps)
    start = 0;
    A_new = A_old - alpha*grad_f_A(A_old,vec_da,mat_aa);
    
    f_A_old = f_A(A_old,scalar_dd,vec_ad,mat_a);
    f_A_new = f_A(A_new,scalar_dd,vec_ad,mat_a);
    % print the current f_val
    f_A_new
    A_old = A_new;
end


function [grad_A] = grad_f_A(A,vec_da,mat_aa)
%% Compute the gradient of f w.r.t A
% A should be a row vector
% vec_da = sum@ d_i*a_i' row vector
% mat_aa = sum@ a_i*a_i' a 3x3 matrix
% both vec_da and mat_aa has been precomputed.
 grad_A =  A*mat_aa - vec_da;
end

function [f_val] = f_A(A,scalar_dd,vec_ad,mat_a)
%% Compute the current value of objective under param A
% A should be [ row vector ]
% scalar_dd = sum@ d_i*d_i [ scalar ]
% vec_ad = sum@ d_i*a_i [ column vector ]
% mat_a is composed of m 3-dims vector [ matrix of size mx3 ]

% A_a = sum@ A*a_i
A_a = A*mat_a';
f_val = scalar_dd - 2*A*vec_ad + A_a*A_a';

end

end