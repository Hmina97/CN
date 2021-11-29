function [L,U] = mylu3b(A)

    n = size ( A, "r");
    for k = 1:n-1
       for i = k+1:n
           A(i,k) = A(i,k)/A(k,k);
       end
       for i = k+1:n
           for j = k+1:n
               A(i,j) = A(i,j) - A(i,k)*A(k,j);
           end
       end
    end
    L = tril(A);
    U = triu(A);
    disp(L);
    disp(U);

   
endfunction
