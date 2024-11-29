% Parâmetros do sistema (exemplo)
num_desejado = [1];
den_desejado = [1 10];
alfa = 10; % Fator de ajuste do compensador

% Função de transferência desejada
Gdes = tf(num_desejado, den_desejado);

% Função de transferência do compensador de atraso
syms R1 C1 s
Gcomp = (1 + s*R1*C1) / (1 + s*alfa*R1*C1);

% Igualando os coeficientes das funções de transferência
[num_comp, den_comp] = tfdata(Gcomp, 'v');
eqns = [coeffs(num_desejado*num_comp - den_desejado*den_comp, s) == 0];

% Resolvendo o sistema de equações
sol = vpasolve(eqns, [R1 C1]);

% Exibindo os resultados
disp(sol)