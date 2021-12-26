
function [B]=cholesky(A)
    n = size(A,1); //Nombre de ligne de matrice
    B = zeros(n,n);
    for j=1:n
        s = A(j,j) - B(j,1:j) * B(j,1:j)';
        B(j,j) = sqrt(s);
        B(j+1:n,j) = 1/B(j,j) * (A(j+1:n,j) - B(j+1:n,1:j) * B(j,1:j)');
    end
endfunction

function [x]=solsup(U,b)
    n = size(U,1); //Nombre lignes de matrice
    x = zeros(n,1);
    x(n) = 1/U(n,n) * b(n);
    for i=n-1:-1:1
        x(i) = 1/U(i,i) * (b(i) - U(i,i+1:n) * x(i+1:n));
    end
endfunction

function [x]=solinf(L,b)
    n = size(L,1); //Nombre lignes de matrice
    x = zeros(n,1);
    x(1) = b(1)/L(1,1);
    for i=2:n 
        x(i) = 1/L(i,i)*(b(i)-L(i,1:i-1)*x(1:i-1));
    end
endfunction

function [x]=resolchol(A,b)
    //Calcule C
    [C] = cholesky(A);
    //Calcule y
    [y] = solinf(C,b);
    //Calcule x
    [x] =  solsup(C',y);
endfunction
