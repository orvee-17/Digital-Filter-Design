%Noise Signal Creation
x= cos(2*pi*20*[0:0.001:1.23]);
x(end) = [];
[b,a] = butter(2,[0.7 0.8],'bandpass');
filtered_noise = filter(b,a,randn(1, length(x)*2));
noise = (x + 0.6*filtered_noise(500:500+length(x)-1))/length(x)*2;
 
%Designing Butterworth & Chebyshev Filter
%Given specification
wp = (100/(2*pi))/100;
ws = (200/(2*pi))/100;
Apass = 0.5;
Astop = 20;
 
%CHEBYSHEV
%[N,wn] = cheb1ord(wp,ws,0.5,20);
%[b,a] = cheby1(N,0.5,wn);
 
%BUTTERWORTH
[N,wn] = buttord(wp,ws,0.5,20);
[b,a] = butter(N,wn);
 
%Filter Signal
noise_filtered = filter(b,a,noise);
 
%Before doing the filter
snr_pre = mean(x.^2) / mean(filtered_noise.^2);
snr_before_db = 10 * log10(snr_pre) % in decibel
 
%After doing the filtering
residual_noise = x - noise_filtered; 
snr_after = mean(x.^2) / mean(residual_noise.^2); 
snr_after_db = 10 * log10(snr_after)% in decibel
