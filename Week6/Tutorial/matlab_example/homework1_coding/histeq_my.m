function img_out = histeq_my(img_in, L)
%HISTEQ_MY just another implementation of histeq
%   Detailed explanation please refer to histeq.
r = zeros(256,1);
for I = img_in
    for J = I'
        r(J+1) = r(J+1) + 1;
    end
end
s = zeros(size(r));
for I = 1:size(r)
    s(I) = (L-1) *  sum(r(1:I)) / sum(r);
end

s_round = round(s);
% redraw color
img_out = img_in;
for I = 1:size(img_out, 1)
    for J = 1:size(img_out, 2)
        img_out(I,J) = s_round(img_out(I,J)+1); % +1 for 0-255 -> 1-256
    end
end
    
end