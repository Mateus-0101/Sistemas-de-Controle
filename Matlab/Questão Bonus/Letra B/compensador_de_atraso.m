compensador_num = [7.8125];    % Numerador da função de transferência compensador
compensador_den =conv([1/0.8,1],[1/0.8, 1]);  % Denominador da função de transferência copmpensador
Gc = tf(compensador_num, compensador_den);

numerador = [19.45];    % Numerador da função de transferência
denominador = conv(conv([1,1], [1/5,1]),[1/10,1]);  % Denominador Normalizado
G = tf(numerador, denominador);

sistemaCompensado = Gc*G;
FTMF = feedback(sistemaCompensado,1);
% Diagrama de Bode e cálculo da margem de fase
figure;
margin(sistemaCompensado);  % Plota o diagrama de Bode e exibe as margens de ganho e fase
title('Diagrama de Bode com Margem de Fase');

% Resposta ao degrau unitário
figure;
step(sistemaCompensado);  % Plota a resposta ao degrau unitário
title('Resposta ao Degrau Unitário - COMPENSADO');
grid on;
