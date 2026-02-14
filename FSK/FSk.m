% fsk.m
close all;
clear all;

bit_pattern = [1 0 0 1 1 0 1 1 1 0 1 1 0 0 0 1 1 1 1 0 0 0 1 1];

Cf0 = 0.8e6;   % Carrier frequency for binary 0 (0.8 MHz)
Cf1 = 2.4e6;   % Carrier frequency for binary 1 (2.4 MHz)

delt = 1e-8;   % Sampling interval (10 ns)
fs = 1/delt;   % Sampling frequency (100 MHz)

samples_per_bit = 250;   % 250 samples per bit

tmax = (samples_per_bit*length(bit_pattern)-1)*delt;
t = 0:delt:tmax;

%% Generate binary signal
bits = zeros(1,length(t));

for bit_no = 1:length(bit_pattern)
    start_index = (bit_no-1)*samples_per_bit + 1;
    end_index   = bit_no*samples_per_bit;
    bits(start_index:end_index) = bit_pattern(bit_no);
end

%% Plot information signal
figure;
subplot(2,1,1);
plot(t,bits);
ylabel('Amplitude');
title('Information Signal');
axis([0 tmax -0.5 1.5]);

%% FSK Modulation
FSK = zeros(1,length(t));   % Preallocate

for bit_no = 1:length(bit_pattern)
    
    start_index = (bit_no-1)*samples_per_bit + 1;
    end_index   = bit_no*samples_per_bit;
    
    t_bit = t(start_index:end_index);
    
    if bit_pattern(bit_no) == 1
        FSK(start_index:end_index) = sin(2*pi*Cf1*t_bit);
    else
        FSK(start_index:end_index) = sin(2*pi*Cf0*t_bit);
    end
end

%% Plot FSK signal
subplot(2,1,2);
plot(t,FSK);
ylabel('Amplitude');
title('FSK Modulated Signal');
axis([0 tmax -1.5 1.5]);
xlabel('Time (seconds)');
