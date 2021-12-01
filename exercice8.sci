function [C] = matmat1b(A,B)
m = size(A,1);
n = size(B,2);
p = size(B,1);
C = zeros(m,n);

for i = 1 : m
    C(i,:) = A(i,:)*B + C(i,:);
end
endfunction

function [C] = matmat2b(A,B)

m = size(A,1);
n = size(B,2);
p = size(B,1);
C = zeros(m,n);

for i = 1 : m
   for j = 1 : n
     C(i,j) = A(i,:)*B(:,j) + C(i,j);
   end
end
endfunction

function [C] = matmat3b(A,B)
m = size(A,1);
n = size(B,2);
p = size(B,1);
C = zeros(m,n);

for i = 1 : m
  for j = 1 : n
    for k = 1 : p
      C(i,j) = A(i,k)*B(k,j) + C(i,j);
    end
  end
end
endfunction


T_1 = zeros(10);
T_2 = zeros(10);
T_3 = zeros(10);



tabsize = [5:5:50];


for n = tabsize

i = n / 5;

// Initialisation des matrices
A = rand(n, n);
B = rand(n, n);

// 
tic;
C = matmat3b(A, B);
T_3(i) = toc();

tic;
D = matmat2b(A, B);
T_2(i) = toc();

tic;
E = matmat1b(A, B);
T_1(i) = toc();


end

// Plot
xtitle("matmat3b", "n", "time");
plot(tabsize, [T_3]);
legend(["matmat3b"], 1);
xs2png(0, "graph\matmat3b.png");
clf();

xtitle("matmat2b", "n", "time");
plot(tabsize, [T_2]);
legend(["matmat2b"], 1);
xs2png(0, "graph\matmat2b.png");
clf();

xtitle("matmat1b", "n", "time");
plot(tabsize, [T_1]);
legend(["matmat1b"], 1);
xs2png(0, "graph\matmat1b.png");
clf();
