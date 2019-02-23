A = [[2,1,1],[1,2,1],[1,1,2]];
A = reshape(A,[3,3]);
m = 50;
mat_a = randi([1,2],[m,3]);

d = zeros(m,3);
for i=1:m
    size(mat_a(i,:))
    d(i,:) = mat_a(i,:)*A';
end

A_param = zeros(3,3);
for i=1:3
A_param(i,:) = Get_param(d(:,i),mat_a);
end