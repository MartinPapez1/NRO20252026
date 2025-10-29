clc;
clear all;

imp = importdata("naloga1_1.txt");
t = imp.data

file_id = fopen("naloga1_2.txt");
line = fgetl(file_id);
parts = strsplit(line, ':');
n = str2double(strtrim(parts{2}));

P = zeros(n, 1);

for i = 1:n
    P(i) = fscanf(file_id, '%f', 1);
end
P

plot(t, P, '-')
xlabel('t [s]')
ylabel('P [W]')
title('graf P(t)')


I = 0;

for i = 1:n-1
    % širina trapeza
    dt = t(i+1) - t(i);
    % trapezna površina
    I = I + 0.5 * (P(i) + P(i+1)) * dt;
end

fprintf('Integral po trapezni metodi = %.16f\n', I);


I_trapz = trapz(t, P);
fprintf('Integral z vgrajeno trapz = %.16f\n', I_trapz);
... Napaka se pojavi na 15. decimalki.