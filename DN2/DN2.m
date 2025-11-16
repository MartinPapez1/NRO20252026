clear; 
clc;

%% ===== BRANJE PODATKOV IZ DATOTEKE =====
fid = fopen('vozlisca_temperature_dn2_24.txt','r');

% 1. vrstica (imena stolpcev)
header = fgetl(fid);

% 2. vrstica: izvlečemo Nx
line2 = fgetl(fid);
Nx = sscanf(line2, 'st. koordinat v x-smeri: %d');

% 3. vrstica: Ny
line3 = fgetl(fid);
Ny = sscanf(line3, 'st. koordinat v y-smeri: %d');

% 4. vrstica: Nv
line4 = fgetl(fid);
Nv = sscanf(line4, 'st. vseh vozlisc: %d');

% Preostale vrstice
C = textscan(fid, '%f %f %f', 'Delimiter', ',', 'MultipleDelimsAsOne', true);

fclose(fid);

x = C{1};
y = C{2};
T = C{3};

% preverjanje
fprintf("Prebranih vozlišč: %d (pričakovano %d)\n", length(x), Nv);


% Točka, kjer interpoliramo
px = 0.403;
py = 0.503;

%% ================== 1. scatteredInterpolant ==================
tic;
F1 = scatteredInterpolant(x, y, T, 'linear');
T_scattered = F1(px, py);
t_scattered = toc;

%% ================== 2. griddedInterpolant ==================
xu = unique(x);    % velikost Nx = 1481
yu = unique(y);    % velikost Ny = 961

[Xg, Yg] = ndgrid(xu, yu);   % NDGRID struktura

TT = reshape(T, Nx, Ny);   % velikost 961 × 1481  (NY × NX)

tic;
F2 = griddedInterpolant(Xg, Yg, TT, 'linear');
T_gridded = F2(0.403, 0.503);
t_gridded = toc;

%% ================== 3. Najbližji sosed ==================
tic;
dist = sqrt((x - px).^2 + (y - py).^2);
[~, idx_min] = min(dist);
T_nearest = T(idx_min);
t_nearest = toc;

%% ================== IZPISI ==================
fprintf("\n================ REZULTATI ================\n");
fprintf("scatteredInterpolant: T = %.5f, čas = %.6f s\n", T_scattered, t_scattered);
fprintf("griddedInterpolant:   T = %.5f, čas = %.6f s\n", T_gridded,   t_gridded);
fprintf("Najbližji sosed:      T = %.5f, čas = %.6f s\n", T_nearest,   t_nearest);

%% ================== NAJVEČJA TEMPERATURA ==================
[maxT, idx_max] = max(T);
fprintf("\nNajvečja temperatura: %.5f\n", maxT);
fprintf("Koordinate: x = %.5f, y = %.5f\n", x(idx_max), y(idx_max));


