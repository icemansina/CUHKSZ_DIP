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
      disp(i+j)
      % use break
      if j > 3
          break
      end
   end
end

i = 1;
while i <= 3
    % use contiune
    if i < 2
        continue
    end
    disp("current i is:")
    disp(i)
    i = i + 1;
end


% Array Indexing, vector and matrix are both array
% =========================================================================















