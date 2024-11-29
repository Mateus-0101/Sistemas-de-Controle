% Define os polos e zeros da função de transferência
numerador = [1]; % Não há zeros
denominador = conv([1 1], [1 2]); % Polos em -1 e -2

% Adicionando um polo em zero (1/s)
denominador_novo = conv(denominador, [1 0]);

% Criando a função de transferência
sys = tf(numerador, denominador_novo);

% Traçando o Lugar Geométrico das Raízes
figure;  % Cria uma nova figura
rlocus(sys);  % Plota o LGR da função de transferência
title('Lugar Geométrico das Raízes');
xlabel('Parte Real');
ylabel('Parte Imaginária');
grid on;  % Adiciona uma grade ao gráfico
hold on;  % Mantém a figura atual para adicionar a reta e as assíntotas

% Cálculo dos polos e zeros
polos = pole(sys);  % Obtém os polos
zeros = zero(sys);  % Obtém os zeros

% Número de polos e zeros
n_p = length(polos);  % Número de polos
n_z = length(zeros);  % Número de zeros

% Cálculo das assíntotas
n_a = n_p - n_z;  % Número de assíntotas
if n_a > 0
    % Centro das assíntotas
    centro = (sum(polos) - sum(zeros)) / n_a;

    % Ângulos das assíntotas
    angulos = (2*(0:n_a-1) + 1) * (180 / n_a);
    
    % Convertendo ângulos para radianos
    angulos_rad = deg2rad(angulos);
    
    % Plotando as assíntotas
    for k = 1:n_a
        % Coordenadas das assíntotas
        x_assintota = [real(centro), real(centro) + 10 * cos(angulos_rad(k))];  % Traço horizontal
        y_assintota = [imag(centro), imag(centro) + 10 * sin(angulos_rad(k))];  % Traço vertical
        plot(x_assintota, y_assintota, 'r--', 'LineWidth', 1.5);  % Plota assíntota em vermelho
    end
end

% Adicionando a reta com ângulo θ = 60 graus
theta = -60;  % Ângulo em graus
theta_rad = deg2rad(theta);  % Convertendo para radianos

% Definindo a inclinação da reta
slope = tan(theta_rad);  % Inclinação

% Definindo pontos da reta
x_values = linspace(-5, 0, 100);  % Intervalo de x para o lado negativo
y_values = slope * x_values;  % Equação da reta passando pela origem

% Plota a reta
plot(x_values, y_values, 'b-', 'LineWidth', 2);  % Reta em azul
legend('LGR', 'Assíntotas', 'Reta θ = 60°');

% Plotando a resposta ao degrau do sistema
figure;  % Cria uma nova figura para a resposta ao degrau
step(sys);  % Plota a resposta ao degrau do sistema
title('Resposta ao Degrau do Sistema');
xlabel('Tempo (s)');
ylabel('Resposta');
grid on;  % Adiciona uma grade ao gráfico


