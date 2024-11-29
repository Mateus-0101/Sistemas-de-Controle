% Definição da função de transferência

% Adicionando um polo em 0 -> alternado o tipo do sistema
% Adicionando um zero em 0.3
num = conv(conv([1 11.34],[1 8]),[1 0.3]);
den = conv(conv([1 3], [1 10]), conv([1 6], [1 0]));
G = tf(num, den);

% Cálculo dos pólos e zeros
poles = pole(sistema);
zeros = zero(sistema);

% Número de pólos e zeros
n_polos = length(poles);
n_zeros = length(zeros);

% Cálculo do centroide e ângulos das assíntotas
centroide = (sum(poles) - sum(zeros)) / (n_polos - n_zeros);
angulos_assintotas = deg2rad(180 * (2 * (0:(n_polos - n_zeros - 1)) + 1) / (n_polos - n_zeros));
% Plot do Lugar das Raízes (LGR)
figure;
rlocus(G);
title('Lugar das Raízes (LGR)');
grid on;
hold on;

% Valor real máximo para extender a reta e assíntotas
max_real = max(abs(real(poles))) * 2;  % Ajuste para garantir a visualização das assíntotas

% Adiciona a reta de 63,25º ao gráfico
plot([0, -max_real * cos(theta)], [0, max_real * sin(theta)], 'r--', 'DisplayName', 'Reta de 63,25º');
plot([0, -max_real * cos(theta)], [0, -max_real * sin(theta)], 'r--');
% Plot das assíntotas
for k = 1:length(angulos_assintotas)
    angle = angulos_assintotas(k);
    plot([real(centroide), real(centroide) + max_real * cos(angle)], ...
         [imag(centroide), imag(centroide) + max_real * sin(angle)], ...
         'g--', 'DisplayName', sprintf('Assíntota em %.1fº', rad2deg(angle)));
end


% Plot da resposta ao degrau para o ganho K encontrado
figure;
step(feedback(K*G, 1));
title('Resposta ao Degrau do Sistema em Malha Fechada');
grid on;

% Análise do erro de regime
% Cálculo do ganho estático de posição Kp
Kp = dcgain(K*G);

% Cálculo do erro de regime para entrada degrau unitário
erro_regime = 1 / (1 + Kp);

% Exibe o erro de regime
fprintf('Erro de regime para entrada degrau unitário: %.4f\n', erro_regime);
