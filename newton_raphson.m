function [result] = newton_raphson(X0, Es, max_iter, equation, handles)

column = {'Xi-1' 'Xi' 'f(Xi-1)' 'f(Xi)' 'Es'};
set(handles.table,'ColumnName' , column);

Xnow = X0;
Xprev = X0;
iterations = max_iter;

cla;
p = ezplot(equation);
set(p, 'Color', 'black', 'LineWidth', 2);
hold on;

tic;
for i = 1:max_iter
    fx_1 = double(getfx(equation, Xprev));
    dfx = double(getndfx(equation, 1, Xprev));
    
    if dfx == 0
        iterations = i;
        break
    end
    
    Xnow = double(Xprev - (fx_1 * 1.0 / dfx));
    fx = double(getfx(equation, Xnow));
    
    error = double(abs(Xnow - Xprev));
    
    if error < Es
        iterations = i;
        break
    end
    
    table(i,:) = [Xprev Xnow fx_1 fx error];
    Xprev = Xnow;
end

exec_time = toc;
set(handles.execution_time_text, 'String', exec_time);
set(handles.table, 'Data', table);
set(handles.num_iterations_text, 'String', iterations);
result = Xnow;

hold off;

end