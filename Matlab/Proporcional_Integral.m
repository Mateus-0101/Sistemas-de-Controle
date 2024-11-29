s = tf('s');

% Cria a função de transferência como um objeto LTI (Linear Time-Invariant)
G = 1/((s+1)*(s+2)*(s+10));

% Inicializa k
k = 1; % Valor inicial de k
z_target = 0.2; % Valor alvo para o coeficiente de amortecimento
max_k = 100; % Limite superior para k

% Loop para encontrar o valor adequado de k
while k <= max_k
    % Sistema em malha fechada
    sys_cl = feedback(k * G, 1);
    
    % Obtem os polos do sistema em malha fechada
    poles = pole(sys_cl);
    
    % Calcula o coeficiente de amortecimento para o pólo dominante
    % Considera o pólo com a menor parte real (dominante)
    dominant_pole = min(real(poles));
    damping_ratio = -dominant_pole / abs(dominant_pole);
    
    % Verifica se o coeficiente de amortecimento está abaixo do alvo
    if damping_ratio < z_target
        break; % Sai do loop se a condição for atendida
    else
        k = k + 0.1; % Aumenta k para tentar melhorar o desempenho
    end
end

% Verifica se encontramos um valor de k que atende à condição
if k > max_k
    disp('Não foi possível encontrar um valor de k que satisfaça z < 0.2.');
else
    % Exibe o valor de k encontrado
    disp(['Valor de k encontrado: ', num2str(k)]);
    
    % Plota o gráfico de lugar das raízes
    figure;
    rlocus(k * G);
    grid on;

    % Plota a resposta ao degrau do sistema em malha fechada
    figure;
    stepplot(sys_cl);
    grid on;
end