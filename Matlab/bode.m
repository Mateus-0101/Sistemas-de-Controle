% Definindo a função de transferência
% NORMALIZADO
% Definindo o numerador e o denominador da função de transferência
num = 100; % Numerador da função de transferência
den = [1 5 0]; % Denominador da função de transferência
% Criando a função de transferência
G = tf(num, den);

% Plotando o diagrama de Bode
bode(G);
margin(G);
% Adicionando rótulos aos eixos
grid on
xlabel('Frequência (rad/s)')
ylabel('Magnitude (dB) / Fase (graus)')
title('Diagrama de Bode')
% Resposta ao degrau unitário
FTMF = feedback(G,1);
figure;
step(FTMF);  % Plota a resposta ao degrau unitário
title('Resposta ao Degrau Unitário - NÃO COMPENSADO');
grid on;