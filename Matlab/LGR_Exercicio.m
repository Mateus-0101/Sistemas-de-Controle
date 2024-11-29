% Define os polos e zeros da função de transferência
numerador = [1]; % Não há zeros
denominador = conv([1 2+2j], [1 2-2j]); % Polos em -2 ± j2
FTMA = tf(numerador, denominador);

% Adicionando um polo(integrador)
denominador_novo = conv(denominador, [1 0]); % Multiplicando o numerador por s (1/s)

% Criando a nova função de transferência com o integrador
FTMA_novo = tf(numerador, denominador_novo);
% Obter polos e zeros
poles = pole(FTMA_novo);
zeros = zero(FTMA_novo);

%poles = pole(FTMA);
%zeros = zero(FTMA);

% Calcula o vértice das assíntotas
sigma_a = (sum(real(poles)) - sum(real(zeros))) / (length(poles) - length(zeros));

% Calcula os ângulos das assíntotas
num_assintotas = length(poles) - length(zeros);
theta_a = (2 * (0:num_assintotas-1) + 1) * 180 / num_assintotas;

% Inicializar uma matriz para armazenar os ângulos de partida para polos complexos
angles_of_departure = [];

% Calcular ângulos de partida para cada polo complexo
for i = 1:length(poles)
    % Considera apenas os polos complexos
    if imag(poles(i)) ~= 0
        % Inicializa a soma dos ângulos de contribuição
        angle_sum = 0;
        
        % Calcula o ângulo de cada outro polo e zero em relação ao polo atual
        for j = 1:length(poles)
            if i ~= j % Ignora o próprio polo
                % Calcula o ângulo entre polos usando atan2(imag, real)
                angle = atan2(imag(poles(j) - poles(i)), real(poles(j) - poles(i)));
                angle_sum = angle_sum + angle; % Soma a contribuição angular
            end
        end
        
        % Somar 180° para obter o ângulo de partida
        angle_departure = rad2deg(pi + angle_sum);
        angles_of_departure = [angles_of_departure; angle_departure]; % Adiciona ao vetor de ângulos de partida
    end
end

% Exibe os resultados calculados
disp(['Vértice das Assíntotas: ', num2str(sigma_a)]);
disp(['Ângulos das Assíntotas: ', num2str(theta_a), ' graus']);
disp('Ângulos de Partida para cada polo complexo:');
disp(angles_of_departure);

% Gera o LGR
figure;
rlocus(FTMA_novo);
%rlocus(FTMA);
title('Lugar das Raízes (LGR) da Função de Transferência');
hold on;

% Destaque as trajetórias dos polos
poles_initial = pole(FTMA_novo); % Polos iniciais com k=0
%poles_initial = pole(FTMA); % Polos iniciais com k=0

% Plota os polos iniciais
plot(real(poles_initial), imag(poles_initial), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
text(real(poles_initial(1)), imag(poles_initial(1)), '  Polo 1', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
text(real(poles_initial(2)), imag(poles_initial(2)), '  Polo 2', 'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');

% Adicionar plotagem das assíntotas
if num_assintotas > 0
    % Para cada ângulo, plota a linha da assíntota
    for k = 1:num_assintotas
        angle_rad = deg2rad(theta_a(k));  % Convertendo para radianos
        % Ponto inicial da assíntota
        x_start = real(sigma_a);
        y_start = imag(sigma_a);
        % Definindo o comprimento da linha da assíntota
        line_length = 10; % Ajuste conforme necessário
        % Ponto final da assíntota
        x_end = x_start + line_length * cos(angle_rad);
        y_end = y_start + line_length * sin(angle_rad);
        % Plota a assíntota
        plot([x_start, x_end], [y_start, y_end], 'r--', 'LineWidth', 1.5); % Assíntota em linha tracejada vermelha
    end
end

% Gera uma grade para facilitar a visualização
grid on;
hold off;



