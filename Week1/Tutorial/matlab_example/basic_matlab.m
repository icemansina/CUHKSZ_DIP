% basic matlab

% control flow
% =========================================================================
% if - elseif - else - end
% -------------------------------------------------------------------------
a = randi(100, 1);

if a < 30
    disp('small')
elseif a < 80
    disp('medium')
else
    disp('large')
end

% switch - case
% -------------------------------------------------------------------------
[dayNum, dayString] = weekday(date, 'long', 'en_US');

switch dayString
   case 'Monday'
      disp('Start of the work week')
   case 'Tuesday'
      disp('Day 2')
   case 'Wednesday'
      disp('Day 3')
   case 'Thursday'
      disp('Day 4')
   case 'Friday'
      disp('Last day of the work week')
   otherwise
      disp('Weekend!')
end

% for¡¢while¡¢continue¡¢break
% -------------------------------------------------------------------------
for i = 1:3
   for j = 1:5
      % use break to jump out of circulation; 
      % codes behind it will not be executed
      if j > 3
          disp("break")
          break
          disp("this will not be executed")
      else
          disp(i+j)
      end
   end
end

i = 0;
while i <= 3
    i = i + 1;
    % use contiune to jump into next circulation
    % similar to break statement, codes behind continue will not be
    % executed
    if i > 2
        disp("jump into next circulation")
        continue
    end
    disp("current i is:")
    disp(i)
end


% Array Indexing, vector and matrix are both array
% in matlab, index start at 1, this is diffrent from python
% =========================================================================

% Vector Indexing
% -------------------------------------------------------------------------

% create row vector, separator is spaces or commas
v = [1 3 5 7 9];  % v = linspace(1, 9, 5);

% get elements by index
v(2); v(2:4); v(3:end);

% start at 1, count up by 2 and stop at last element
v(1:2:end);

% steps can be negative
v(end:-2:1);

% convert to column vector by transpose operator
w = v.';

% Matrix Indexing
% -------------------------------------------------------------------------

% matrix is a sequence of row vectors, and separated by semicolons
A = [1 2 3; 4 5 6; 7 8 9];

% first index is row location, second index is column location
A(2,3);
A(1:2, 1:3);  % extract the top two rows

% single colon means all
A(:, 3); % equal to A(1:3, 3)


