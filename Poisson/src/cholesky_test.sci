
//
format("e", 16);

//
s = 10
rand("seed", s);

// Init vectors
times = zeros(10);
x = zeros(10);
ferror = zeros(10);
condA = zeros(10);

// xdata
xdata = [10:10:100];

// Loop
for n = xdata

        i = n / 10;
	
	// Init matrix
	A = rand(n, n);

	// LU
	tic();
	C = cholesky(A);
	
	times(i) = toc();

	// x3
	x(i) =   3 * 10^(-4) * n;

	// error
	ferror(i) = norm(A - C) / norm(A);

	// cond
	condA(i) = cond(A);

end

xtitle("Times per size", "sizes of matrix", "times (second)");
plot(xdata, [times x]);
legend(["cholesky" " 5 * 10^(-2) * x"], 2);
xs2png(0, "cholesky_times.png");
clf();

xtitle("Relative error result", "sizes of matrix", "relative error");
plot(xdata, log(ferror));
xs2png(0, "mylu_error.png");
clf();

xtitle("Condition", "sizes of matrix", "cond");
plot(xdata, log(condA));
xs2png(0, "cholesky_cond.png");
clf();


