function [result] = secant(X0, X1, Es, max_iter, equation, handles)
    
column = {'Xi-1' 'Xi' 'f(Xi-1)' 'f(Xi)' 'Xi+1' 'Es'};
set(handles.table,'ColumnName' , column);

Xnew = 0;
Xprev = X0;
Xnow = X1;

cla;
p = ezplot(equation);
set(p, 'Color', 'black', 'LineWidth', 2);
hold on;

for i = 1:max_iter
    fx = getfx(equation, Xnow);
    fxp = getfx(equation, Xprev);
    
    if fxp - fx == 0
        break
    end
    
    Xnew = Xnow - ((fx * (Xprev - Xnow)) / (fxp - fx)) * 1.0;
    
    error = vpa(abs(Xnew - Xnow));
    
    if error < Es
        break
    end
    
    table(i,:) = [Xprev Xnow fxp fx Xnew Es];
    Xprev = Xnow;
    Xnow = Xnew;
end

set(handles.table, 'Data', table);
result = Xnew;

hold off;
end