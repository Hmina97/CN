function [x] = usolve(U,b)
    b = b';
    n = size(U,1);
    x = zeros(1:n);
    x = x';
    x(n) = b(n)/U(n,n);
    for i = (n-1) : -1 :1
        x(i) = (b(i)-U (i,(i + 1) : n)*x((i + 1) : n))/U(i,i);
     end 
endfunction

function [x] = lsolve(L,b)
b = b'
n = size(L,1);
x = zeros(1:n);
x = x';

x(1) = b(1)/L(1,1);
for i = 2 : n
    x(i) = (b(i)-L(i,1 : (i -1))*x (1 : (i -1))) /L(i,i);
end 
endfunction
 

U_errarr = zeros(10);
U_errav = zeros(10);

L_errarr = zeros(10);
L_errav = zeros(10);



tabsize = [5:5:50];

for n = tabsize

        i = n / 5;
	
	
	A = rand(n, n);
	U = triu(A);
	L = tril(A);
	xex = rand(n, 1);
	
	b = U * xex;

	x = usolve(U, b);
	
	// error
	U_errarr(i) = norm(xex - x, 2) / norm(xex, 2);
	U_errav(i) = norm(b - U * x, 2) / norm(b, 2);

	U_cond(i) = cond(U);


	b = L * xex;

        // L
	x = lsolve(L, b);
	
	// error
	L_errarr(i) = norm(xex - x, 2) / norm(xex, 2);
	L_errav(i) = norm(b - L * x, 2) / norm(b, 2);


end

xtitle("Résultat relatif avant",  "tailles des  matrices", "erreur avant");
plot(tabsize, [log(U_errarr) log(L_errarr)]);
legend(["mat triangulaire sup" "mat triangulaire inf"], 2);
xs2png(0, "graph\LUerreur_arr.png");
clf();

xtitle("Résultat relatif arrière", "tailles des  matrices", "erreur arrière");
plot(tabsize, [log(U_errav) log(L_errav)]);
legend(["mat triangulaire sup" "mat triangulaire inf"], 2);
xs2png(0, "graph\LUerreur_av.png");
clf();

