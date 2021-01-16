function [Contador, Tiempo]= Protocolo(NR,Ventana,NumeroTramas)
Bandera=0;
Bandera2=0;
Contador=zeros(1,4);
Tiempo=zeros(1,NumeroTramas);
index=1;
Tramas=1:NumeroTramas;
time=1;
Contador(1)=NumeroTramas;
while Bandera==0
    tic
    if Bandera2==0
        %Se transmiten las tramas indicadas por la ventana
        for i=1:Ventana
            fprintf('Transmitiendo trama %d\n',Tramas(index));
            index=index+1;   
        end
        Bandera2=1;
    end
    Dado=rand(1);
    if Dado>NR
        fprintf('ACK recibido de la trama %d \n',Tramas(index-Ventana));
        fprintf('Transmitiendo trama %d \n',Tramas(index));
        if Tramas(index)==NumeroTramas
            Bandera=1;
        end
        index=index+1;
    else
        fprintf('Error al recibir ACK  en trama %d\n',Tramas(index-Ventana));
        Contador(2)=Contador(2)+1;
        for j=0:Ventana-1
            fprintf('Descartando trama %d\n',Tramas(index-Ventana+j));
            Contador(3)=Contador(3)+1;
        end
        index=index-Ventana;
        Bandera2=0;
    end
    Tiempo(time)=toc;
    time=time+1;
end
%Se transmiten por separado las ultimas tramas contenidas en la ventana
i=NumeroTramas-Ventana+1;
while (i<=NumeroTramas)
    tic
    Dado=rand(1);
    if Dado>NR
        fprintf('Recibido ACK de trama %d\n',Tramas(i));
        i=i+1;
    else
        fprintf('Error al recibir ACK de la trama %d\n',Tramas(i));
        Contador(2)=Contador(2)+1;
        for j=i:NumeroTramas
            fprintf('Descartando la trama %d\n',Tramas(j));
            Contador(3)=Contador(3)+1;
            fprintf('Transmitiendo trama %d\n',Tramas(j));
        end
    end
    Tiempo(time)=toc;
    time=time+1;
end
Contador(4)=Contador(1)-Contador(2);
end