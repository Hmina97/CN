
function [c] = jouet(n)



// initialisation de marice A et le vecteur xex
A = rand(n, n);
xex = rand(n, 1);

b = A * xex;


x = A \ b;

// erreur avant  et arrière 
err_av = norm(xex - x) / norm(xex);
err_arr = norm(b - A * x) / norm(b);



// Resultat
c = [err_av; err_arr];

endfunction

n = [10:10:100, 200:100:1000];

c = zeros(19, 2);

for i = 1:19
    c(i, :) = jouet(n(i));
end

xtitle("Résultat relatif avant", "n", "err_av");
plot(n, log(c(:, 1)));
xs2png(0, "graph/err_av.png");
clf();

xtitle("Résultat relatif arrière", "n", "err_arr");
plot(n, log(c(:, 2)));
xs2png(0, "graph/err_arr.png");
clf();




