% Definir o polo complexo s1
s1 = complex(-0.3333, 0.5775);

% Calcular Kint
Kint = s1 * (s1 + 1) * (s1 + 2);

% Calcular K
K = abs(Kint); % Ou K = sqrt(real(Kint)^2 + imag(Kint)^2)

% Criar a função de transferência do sistema original
sys = tf(1, [1 3 2 0]);

% Criar a função de transferência do sistema com realimentação
FTMF = K * sys / (1 + K * sys);

% Definir o intervalo de tempo
t = 0:0.01:15;

% Simular a resposta ao degrau unitário
y = step(FTMF, t);

% Plotando o lugar das raízes
rlocus(G);
grid on;  % Adiciona uma grade ao gráfico
hold on;  % Mantém a figura atual para adicionar a reta e as assíntotas

figure;  % Cria uma nova figura
% Plotar a resposta
plot(t, y);
xlabel('Tempo (s)');
ylabel('Saída');
title('Resposta ao Degrau Unitário');
grid on;  % Adiciona uma grade ao gráfico
hold on;  % Mantém a figura atual para adicionar a reta e as assíntotas
