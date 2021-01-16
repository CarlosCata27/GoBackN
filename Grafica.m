function Grafica(Contador,Titulo)
    figure
    stem(1:4,Contador,'filled','r');
    xlabel(Titulo(1,2))
    title(Titulo(1,1))
end