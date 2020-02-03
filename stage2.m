function x =  stage2(A,b)
    
    [m,n] = size(A); % gets the number of rows and columns in the matrix
    mb = length (b);
    
    if m ~= n % check to make sure matrix is square
        disp('Tis not a square matrix')
        return
    else
        disp('Tis but a square Matrix')
    end
    
    if nnz(A) == 0 % checks to see if matrix is full of 0's
        disp('Tis a fully 0 matrix')
        return
    end
    
    if (mb ~= m)
        disp('b Tis not a compatable size with supplied matrix')
        return
    else
        disp('b Tis a compatable size with supplied matrix')
    end
    
    A = [A,b]; % creates the augmented matrix    
    k = 1; % sets counter variable to 1
    
    for i = 1:n-1    
        for j = k:n-1                                 
            l = A(j+1,k)/A(k,k);                     
            A(j+1,:) = A(j+1,:) - l*A(k,:);
        end
        k = k + 1;
    end
    
    z = all(A == 0,2); % Checks each row for a 0 row
    y = sum(z(:)==0);  % Counts the number of none 0 rows
    
    if y < m % Outputs the rank and 0 row information around the converted
             % matrix if number of none 0 rows is less then matrix size
        disp('Matrix contains a 0 row')
        disp('Matrix has a rank of:')
        disp(y)
        disp('Matrix is rank deficient')
        return
    else
        disp('Matrix does not contain a 0 row')
        disp('Matrix has a rank of:')
        disp(y)
    end
    
    x(n) = A(n,n+1)/A(n,n);
    for i = n-1:-1:1
        count = 0;
        for j = i+1:n
            count = count + A(i,j)*x(j);
        end
        x(i) = (A(i,n+1)-count)/A(i,i);
    end
    x = x';
end