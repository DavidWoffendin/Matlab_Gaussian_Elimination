function U =  stage1(A)
    
    [m,n] = size(A); % gets the number of rows and columns in the matrix
    
    k = 1; % sets counter variable to 1

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
    
    for i = 1:n-1    
        for j = k:n-1                                 
            l = A(j+1,k)/A(k,k);                     
            A(j+1,:) = A(j+1,:) - l*A(k,:);
        end
        k = k + 1;
    end
    
    x = all(A == 0,2); % Checks each row for a 0 row
    y = sum(x(:)==0);  % Counts the number of none 0 rows
    
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
    
    U=A;
    