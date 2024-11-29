% Definição dos dois sistemas de transferência
num1 = [1 8];
den1 = conv(conv([1 3], [1 10]), [1 6]);
G1 = tf(num1, den1);

num2 = conv([1 11.34],[1 8]);
den2 = conv(conv([1 3], [1 10]), [1 6]);
G2 = tf(num2, den2);

% Plot das respostas ao degrau no mesmo gráfico
figure;
step(G1, 'b'); % Resposta ao degrau do primeiro sistema em azul
hold on;
step(G2, 'r'); % Resposta ao degrau do segundo sistema em vermelho
hold off;

% Personalização do gráfico
title('Respostas ao Degrau de Dois Sistemas');
legend('Sistema 1', 'Sistema 2');
xlabel('Tempo (s)');
ylabel('Amplitude');
grid on;