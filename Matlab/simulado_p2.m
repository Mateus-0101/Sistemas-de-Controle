% Definindo a função de transferência do sistema
numerador = [1];
denominador = [1, 4, 4, 0];
sistema = tf(numerador, denominador);

% Definir a função de transferência do compensador
num_compensador = [3.36, 0.010752];  % Numerador da função de transferência do compensador
den_compensador = [1, 0.0001];  % Denominador da função de transferência do compensador
compensador = tf(num_compensador, den_compensador);

% Multiplicar a função de transferência do compensador pela do sistema
sistema_compensado = compensador * sistema;

% Ângulo da reta auxiliar para sobressinal de 20%
theta = deg2rad(63.25);  % Ângulo de 63,25º em radianos

% Cálculo dos pólos e zeros
poles = pole(sistema);
zeros = zero(sistema);

% Número de pólos e zeros
n_polos = length(poles);
n_zeros = length(zeros);

% Cálculo do centroide e ângulos das assíntotas
centroide = (sum(poles) - sum(zeros)) / (n_polos - n_zeros);
angulos_assintotas = deg2rad(180 * (2 * (0:(n_polos - n_zeros - 1)) + 1) / (n_polos - n_zeros));

% Plot do Lugar das Raízes com as assíntotas e reta auxiliar
figure;
rlocus(sistema_compensado);
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

title('Lugar das Raízes com Assíntotas e Reta de 63,25º');
xlabel('Parte Real');
ylabel('Parte Imaginária');
legend('show');
hold off;

% Exibe o centroide das assíntotas
disp(['Centroide das assíntotas: ', num2str(real(centroide), '%.2f')]);

FTMF1 = feedback(sistema,1);
% Resposta ao degrau unitário
figure;
step(FTMF1);  % Plota a resposta ao degrau unitário
title('Resposta ao Degrau Unitário - NÃO COMPENSADO');
grid on;


FTMF = feedback(sistema_compensado,1);
% Resposta ao degrau unitário
figure;
step(FTMF);  % Plota a resposta ao degrau unitário
title('Resposta ao Degrau Unitário - COMPENSADO');
grid on;
