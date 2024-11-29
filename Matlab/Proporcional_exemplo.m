
s = tf('s');
% Cria a função de transferência como um objeto LTI (Linear Time-Invariant)
sys = 1/(s*(s+1)*(s+2));
rlocus(sys);
grid on;

figure;
stepplot(sys)
grid on;