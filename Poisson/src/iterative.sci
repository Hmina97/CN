
function [A] = mat_chal(n)
 
	 //
	 A = zeros(n, n);

	 //
	 for i = 1:n
	     A(i, i) = 2;
	 end

	 //
	 for i = 1:n-1
	     A(i + 1, i) = -1;
	     A(i, i + 1) = -1;
	 end

endfunction

function [b] = vec_chal(n, T0, T1)

	 //
	 b = zeros(n, 1);

	 b(1) = T0;
	 for i = 2:n-1
	     b(i) = 0;
	 end
	 b(n) = T1;

endfunction

