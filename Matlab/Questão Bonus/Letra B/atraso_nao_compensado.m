% Definindo a função de transferência
% Frequência inicial = 0.001
numerador = [0.001];    % Numerador da função de transferência
denominador = conv(conv([1,1], [1/5,1]),[1/10,1]);  % Denominador Normalizado
G = tf(numerador, denominador);

FTMF = feedback(G,1);
% Diagrama de Bode e cálculo da margem de fase
figure;
margin(FTMF);  % Plota o diagrama de Bode e exibe as margens de ganho e fase
title('Diagrama de Bode com Margem de Fase');

% Resposta ao degrau unitário
figure;
step(FTMF);  % Plota a resposta ao degrau unitário
title('Resposta ao Degrau Unitário - NÃO COMPENSADO');
grid on;
