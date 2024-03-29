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

zc = all(A == 0,1); % Checks each row for a 0 row
yc = sum(zc(:)==0);  % Counts the number of none 0 rows

zr = all(A == 0,2); % Checks each row for a 0 row
yr = sum(zr(:)==0);  % Counts the number of none 0 rows

if (yc < m) || (yr < m)  % checks for 0 row and column in initial matrix
    disp('Matrix contains a 0 row')
    disp('Matrix is rank deficient')
    return
end

for i = 1:n % iterates through columns 1:n-1
    if abs(A(i,i)) == 0 && i ~= n % implemented row swap to deal with 0
        % values in the diagonal
        temp_row = A(i,:); % copies the top row
        A(i,:) = A(i+1,:); % makes the top row equal to the lower row
        A(i+1,:) = temp_row; % set the lower row equal to the top
    end
    for j = k:n-1 % iterates between k and n-1
        l = A(j+1,k)/A(k,k); % calculates the common factor between the
        % two rows
        A(j+1,:) = A(j+1,:) - l*A(k,:); % the pivot row is multiplied
        % by the common factor to make
        % it equal to the lower row
        % this is then removed from the
        % lower row to make the 0 value        
    end
    k = k + 1; % k is iterated by one to move onto the next column
    % diagonal
end

for i = 1:n
    for j = 1:n
        if abs(A(j,i)) <= 5e-10 % checks current row value to see if
            % it is less than tolerance, if it is it sets it to 0, used to
            % counter matlab precision issues
            A(j,i) = 0;
        end
    end
end

Anan = isnan(A); % Checks each row for a Nan row
ynan = (sum(Anan(:)==0))/n; % Counts the number of non Nan rows

z = all(A == 0,2); % Checks each row for a 0 row
y = sum(z(:)==0);  % Counts the number of none 0 rows

if (y < m) || (ynan < m) % Outputs the rank and 0 row information around the converted
    % matrix if number of none 0 rows is less then matrix size
    disp('Matrix contains a 0 row')
    disp('Matrix is rank deficient')
    return
else
    disp('Matrix does not contain a 0 row')
    disp('Matrix is full rank')
end


U=A; %Makes U = A
