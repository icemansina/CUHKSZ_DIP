% Ref: https://blog.csdn.net/u010592995/article/details/73555425
figure(1)
N = 15;     % 采样数量
f = 1;       % 信号频率1Hz
Fs = 10;     % 采样频率 10Hz
Ts = 0.1;   % 采样间隔 

T = N*Ts;    % 采样时长
n = 0:N-1;    % 时域采样序列(N个采样)
NP = floor( (1/f)/(Ts) );    % 1个周期采样点数
                             % 为了清楚显示波形,只画1个周期                     
nTs = n*Ts;         % 时域采样时间序列
ts = 0:Ts:Ts*N;
x = sin(2*pi*f*ts);  %时域采样,
subplot(211);
stem(ts, x);
title(['sampled signal, Ts=' num2str(Ts)]);

% 下面是为了更好地显示出待采样信号的波形
Ts1 = 0.001;                    
NP1 = floor( (1/f)/(Ts1) );
t1 = [0:T/Ts1-1]*Ts1;   
f1 = sin(2*pi*t1);
hold on;
plot(t1,f1,'r-');
hold off;

% 下面开始用内插法重建信号
% 采样信号: x(n)=f
% 采样间隔: T=Ts
% 原理(内插法): y(t)=Σx(n)sinc((t-nTs)/Ts)
t1 = 0;     % 开始时间
t2 = 1/f;   % 结束时间(取信号的1个周期)

interpfac = 10;
fs_sinc = interpfac * Fs;   % 内插函数的采样率，即源信号过采样的采样率，默认10倍过采样

Dt = Ts / interpfac;
t = t1:Dt:t2;

ta = t1:Dt:Ts*N;
fa = zeros(length(ta),1);

for t = 0:length(ta)-1              % 求过采样后的每个值
    for m = 0:length(nTs)-1         % 累加sinc与原函数对应点的积
        fa(t+1) = fa(t+1) + x(m+1)*sinc((t*Dt - m*Ts)/Ts) ;
    end
end

subplot(212);
stem(ta, fa)
title('Function Reconstruction (Recovery) from Sampled Data');

