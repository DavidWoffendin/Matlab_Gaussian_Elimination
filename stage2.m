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

for i = 1:n % iterates through colums 1:n-1
    if abs(A(i,i)) == 0 && i ~= n % implemented row swap to deal with 0
        % values in the diaganol
        temp_row = A(i,:); % copys the top row
        A(i,:) = A(i+1,:); % makes the top row equal to the lower row
        A(i+1,:) = temp_row; % set the lower row equal to the top
    end
    if abs(A(i,i)) <= 3.0198e-14 % if diaganol is less than tolerance
        % set the diaganol to 0, needed to counter matlabs precision limits
        A(i,i) = 0;
    end
    for j = k:n-1 % iterates between k and n-1
        l = A(j+1,k)/A(k,k); % calculates the common factor between the
        % two rows
        A(j+1,:) = A(j+1,:) - l*A(k,:); % the pivot row is multplied
        % by the common factor to make
        % it equal to the lower row
        % this is then removed from the
        % lower row to make the 0 value
        if abs(A(j+1,i)) <= 3.0198e-14 % checks current row value to see if
            % it is less than tolerance, if it is it sets it to 0, used to
            % counter matlab precision issues
            A(j+1,i) = 0;
        end
    end
    k = k + 1; % k is iterated by one to move onto the next colum
    % diaganol
end

Anan = isnan(A); % Checks each row for a Nan row
ynan = (sum(Anan(:)==0))/n; % Counts the number of none Nan rows

z = all(A == 0,2); % Checks each row for a 0 row
y = sum(z(:)==0);  % Counts the number of none 0 rows

if (y < m) || (ynan < m) % Outputs the rank and 0 row information around the converted
    % matrix if number of none 0 rows is less then matrix size
    disp('Matrix contains a 0 row')
    disp('Matrix has a rank of:')
    if y < m
        disp(y)
    elseif ynan < m
        disp(ynan)
    end
    disp('Matrix is rank deficient')
    return
else
    disp('Matrix does not contain a 0 row')
    disp('Matrix has a rank of:')
    disp(y)
end

% begin backwards substitution
% sets the lowest row with only one x value and simplifies it
x(n) = A(n,n+1)/A(n,n); % simple divides the solution value by the
% x value
% Iterates over the other rows using the original x value
for i = n-1:-1:1
    counter = 0; % starts a counter
    for j = i+1:n % iterates over i+1 to n
        counter = counter + A(i,j)*x(j); % sets counter equal to value
        % multiplied by previous x
        % value
    end
    x(i) = (A(i,n+1)-counter)/A(i,i); % divides the solution value and
    % and add the output to the
    % vector x
end
x = x'; %rotates the vector
end