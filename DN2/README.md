Metoda griddedInterpolant je najhitrejša,ker:



podatki tvorijo regularno mrežo (struktura Nx × Ny),

metoda deluje na strukturiranih podatkih, zato MATLAB izvede interpolacijo z minimalnim številom operacij,

ni iskanja po nestrukturiranih točkah kot pri scatteredInterpolant.



Metoda scatteredInterpolant je počasnejša, ker mora MATLAB najprej izvesti triangulacijo, kar je računsko dražje.



Najhitrejša je lahko tudi metoda najbližjega soseda, vendar ne daje gladkih ali natančnih rezultatov, zato je griddedInterpolant najbolj učinkovita in primerna metoda.

