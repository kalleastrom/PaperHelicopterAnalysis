
nbr_of_prototypes = 11;

% Standard (in cm)
a = 4*ones(nbr_of_prototypes,1);
b = 3.5*ones(nbr_of_prototypes,1);
c = 2*ones(nbr_of_prototypes,1);
d = 3*ones(nbr_of_prototypes,1);
L = 13*ones(nbr_of_prototypes,1);

% Changes (in cm)
b(2) = 4.5; % Model 2
b(3) = 2.5; % Model 3
a(4) = 5;   % Model 4
a(5) = 3;   % Model 5
c(6) = 3;   % Model 6
c(7) = 1;   % Model 7
L(8) = 18;  % Model 8
L(9) = 8;   % Model 9
d(10) = 4;  % Model 10
d(11) = 2;  % Model 11

% Convert from cm to m
a = a.*1e-2;
b = b.*1e-2;
c = c.*1e-2;
d = d.*1e-2;
L = L.*1e-2;

Areas = (2*b).*(a+c+L+1);