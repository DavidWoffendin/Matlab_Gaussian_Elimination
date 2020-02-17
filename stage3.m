function x =  stage3(A,b)

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

zc = all(A == 0,1); % Checks each row for a 0 row
yc = sum(zc(:)==0);  % Counts the number of none 0 rows

zr = all(A == 0,2); % Checks each row for a 0 row
yr = sum(zr(:)==0);  % Counts the number of none 0 rows

if (yc < m) || (yr < m)  % checks for 0 row and column in initial matrix
    disp('Matrix contains a 0 row')
    disp('Matrix is rank deficient')
    return
end

if (iscolumn(b) ~= 1)
    disp('b Tis not a compatible column vector with supplied matrix')
    return
else
    disp('b Tis a compatible column vector with supplied matrix')
end

if (mb ~= m)
    disp('b Tis not a compatable size with supplied matrix')
    return
else
    disp('b Tis a compatable size with supplied matrix')
end

A = [A,b]; % creates the augmented matrix
k = 1; % sets counter variable to 1

for i = 1:n % iterates through columns 1:n-1
    for j = i+1:n %iterates through rows 1+1:n
        if abs(A(j,i)) > abs(A(i,i)) % implemented row swap to deal with 0
            % values in the diagonal
            temp_row = A(i,:); % copys the top row
            A(i,:) = A(j,:); % makes the top row equal to the lower row
            A(j,:) = temp_row; % set the lower row equal to the top
        end
    end
    if abs(A(i,i)) <= 5e-10% if diagonal is less than tolerance
        % set the diagonal to 0, needed to counter matlabs precision limits
        A(i,i) = 0;
    end
    if A(i,i) ~= 1 % if diagonal does not equal 1
        A(i,:) = A(i,:)./A(i,i); % divide diagonal row by diagonal
    end
    for j = k:n-1 % iterates between k and n-1
        l = A(j+1,k)/A(k,k); % calculates the common factor between the
        % two rows
        A(j+1,:) = A(j+1,:) - l*A(k,:); % the pivot row is multplied
        % by the common factor to make
        % it equal to the lower row
        % this is then removed from the
        % lower row to make the 0 value
    end
    k = k + 1; % k is iterated by one to move onto the next colum
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

UnaugmentedA = A;
UnaugmentedA(:,n+1) =  [];

Anan = isnan(UnaugmentedA); % Checks each row for a Nan row
ynan = (sum(Anan(:)==0))/n; % Counts the number of none Nan rows

z = all(UnaugmentedA == 0,2); % Checks each row for a 0 row
y = sum(z(:)==0);  % Counts the number of none 0 rows

if (y < m) || (ynan < m) % Outputs the rank and 0 row information around 
    % the converted matrix if number of none 0 rows is less then matrix
    % size
    disp('Matrix contains a 0 row')
    disp('Matrix is rank deficient')
    return
else
    disp('Matrix does not contain a 0 row')
    disp('Matrix is full rank')
end

% begin backwards substitution
% gets the last row with only one x value and simplifies it
x(n) = A(n,n+1)/A(n,n); % simple divides the solution value by the
% x value and sets the answer to the soluction vector
% Iterates over the other rows using the original x value from bottum up
for i = n-1:-1:1
    counter = 0; % starts a counter
    for j = i+1:n % iterates over i+1 to n
        counter = counter + A(i,j)*x(j); % sets counter equal to value
        % multiplied by previous x value
    end
    x(i) = (A(i,n+1)-counter)/A(i,i); % divides the solution value minus 
    % the counter by the diaganol and then adds the output to the soluction
    % vector
end
x = x'; %rotates the vector
end