function [C] = matmat1b(A,B)
    
    C = zeros(size(A,"r"),size(B,"c"));
    for i = 1 : size(A,"r")
        C(i,:) = A(i,:)*B + C(i,:); 
    end
endfunction

function [C] = matmat2b(A,B)

C = zeros(size(A,"r"),size(B,"c"));
for i = 1 :  size(A,"r")
   for j = 1 : size(B,"c")
     C(i,j) = A(i,:)*B(:,j) + C(i,j);
   end
end
endfunction

function [C] = matmat3b(A,B)
    
C = zeros(size(A,"r"),size(B,"c"));
for i = 1 : size(A,"r")
  for j = 1 : size(B,"c")
    for k = 1 : size(B,"r")
      C(i,j) = A(i,k)*B(k,j) + C(i,j);
    end
  end
end
endfunction


tabsize = [5;10;20;40;80;160];
//n = size(tabsize)
T_1 = zeros(size(tabsize,"r"));
T_2 = zeros(size(tabsize,"r"));
T_3 = zeros(size(tabsize,"r"));

i = 1;
while i <  size(tabsize,"r")+1

    // Initialisation des matrices
    A = rand(tabsize(i), tabsize(i));
    B = rand(tabsize(i), tabsize(i));
 
    tic;
    C = matmat3b(A, B);
    T_3(i) = toc();

    tic;
    D = matmat2b(A, B);
    T_2(i) = toc();

    tic;
    E = matmat1b(A, B);
    T_1(i) = toc();

    i = i+1;
end

// Plot
xtitle("matmat3b", "n", "time");
plot(tabsize, [T_3]);
legend(["matmat3b"], 1);
xs2png(0, "img\matmat3b.png");
clf();

xtitle("matmat2b", "n", "time");
plot(tabsize, [T_2]);
legend(["matmat2b"], 1);
xs2png(0, "img\matmat2b.png");
clf();

xtitle("matmat1b", "n", "time");
plot(tabsize, [T_1]);
legend(["matmat1b"], 1);
xs2png(0, "img\matmat1b.png");
clf();
