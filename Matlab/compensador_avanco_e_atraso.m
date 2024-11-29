% Definição da função de transferência
num = [1 8];
den = conv(conv([1 3], [1 10]), [1 6]);
G = tf(num, den);

% Plot do Lugar das Raízes (LGR)
figure;
rlocus(G);
title('Lugar das Raízes (LGR)');
grid on;
hold on;

% Adiciona a reta do coeficiente de amortecimento de 0,45
zeta = 0.45;
theta = acos(zeta); % Ângulo correspondente ao coeficiente de amortecimento
sgrid(zeta, 0); % Plota a linha de constante zeta

% Determina a posição no LGR para o amortecimento desejado
[K, poles] = rlocfind(G);

% Plot da resposta ao degrau para o ganho K encontrado
figure;
step(feedback(K*G, 1));
title('Resposta ao Degrau do Sistema em Malha Fechada');
grid on;
