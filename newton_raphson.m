function [result] = newton_raphson(X0, Es, max_iter, equation, handles)

column = {'Xi-1' 'Xi' 'f(Xi-1)' 'f(Xi)' 'Es'};
set(handles.table,'ColumnName' , column);

Xnow = X0;
Xprev = X0;

cla;
p = ezplot(equation);
set(p, 'Color', 'black', 'LineWidth', 2);
hold on;

for i = 1:max_iter
    fx_1 = getfx(equation, Xprev);
    dfx = getndfx(equation, 1, Xprev);
    
    if dfx == 0
        break
    end
    
    Xnow = Xprev - (fx_1 * 1.0 / dfx);
    fx = getfx(equation, Xnow);
    
    error = vpa(abs(Xnow - Xprev));
    
    if error < Es
        break
    end
    
    table(i,:) = [Xprev Xnow fx_1 fx Es];
    disp([Xprev Xnow fx_1 fx Es]);
    Xprev = Xnow;
end

set(handles.table, 'Data', table);
result = Xnow;

hold off;

end