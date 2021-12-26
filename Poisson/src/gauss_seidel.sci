function [x, count, residual, relres] = gauss_seidel(A, b, e, max_count)

	 // Size of matrix A
	 n = max(size(A));

	 // D
	 D = zeros(n, n);
	 for i = 1:n
	     D(i, i) = A(i, i);
	 end

	 // E
	 E = zeros(n, n);
	 for i = 2:n
	     E(i, i - 1) = - A(i, i - 1);
	 end

	 // (D - E)-1
	 DE = inv(D - E);

	 x = zeros(n, 1);

	 normb = norm(b);
	 
	 r = (b - A * x);
	 residual = norm(r) / normb;
	
	 relres = zeros(max_count, 1);
     
     for count = 0:max_count
         
	  if( residual < e) then
	       break;
      end;
		x = x + DE * r;
		r = (b - A * x);

		//
		count = count + 1;

		//
		residual = norm(r) / normb;
		relres(count) = residual;
	 end

endfunction
