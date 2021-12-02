
function [x] = gausskij3b (A,b)
    n = size (A,"c");
    for k = 1:n-1
        for i = k+1:n
            mik = A(i,k)/A(k,k);
            b(i) = b(i) - mik * b(k);
            for j = k+1:n
               A(i,j) = A(i,j) - mik * A(k,j); 
            end
        end
    end
    x = usolve (A,b);
endfunction

tabsize = [10;20;30;40;50;60;70;80;90;100];
G_errarr = zeros(size(tabsize,"r"));
G_errav = zeros(size(tabsize,"r"));


i = 1;
while i < size(tabsize,"r")+1


	A = rand(size(tabsize,"r"), size(tabsize,"r"));
	xex = rand(size(tabsize,"r"), 1);

	// b
	b = A * xex;

	// x
	x = gausskij3b(A, b);
	
	// error
	G_errav(tabsize(i)) = norm(xex - x, 2) / norm(xex, 2);
	G_errarr(tabsize(i)) = norm(b - A * x, 2) / norm(b, 2);

	// cond
	
    i = i+1;
end

xtitle("Resultat erreur relatif", "taille matrice", "erreur relatif");
plot(tabsize, [log(G_errav) log(G_errarr)]);
legend([" erreur avant" " erreur arriere"], 2)
xs2png(0, "img/gauss_error.png");
clf();

