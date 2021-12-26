function [x, count, residual, relres] = jacobi(A, b, e, max_count)

	  //la taille de matrice A
	 n = max(size(A));

	 // D-1
	 D = 1 / 2; 
	 x = zeros(n, 1);

	 // Norm of b
	 normb = norm(b);

	 // Residual
	 r = (b - A * x);
	 residual = norm(r) / normb;

	 // Residula vector 
	 relres = zeros(max_count, 1);

	 //
	 for count = 0:max_count
         
	  if( residual < e) then
	       break;
      end;
	       	//
		x = x + D * r;
		r = (b - A * x);

		//
		count = count + 1;

		//
		residual = norm(r) / normb;
		relres(count) = residual;
	 end

endfunction
