clc;
clear all;
NumeroTramas=1000;
Ventana=3;
%Ventana=5;
index=1;
flag=0;
flag2=0;
Tramas=1:NumeroTramas;
NR=[0.01 0.1];
Contador=zeros(1,4);
error=0;

Tiempos=zeros(1,NumeroTramas);
Contador(1)=NumeroTramas;
while flag==0
    if flag2==0
        %Se transmiten las tramas indicadas por la ventana
        tic;
        for i=1:Ventana
            fprintf('Transmitiendo trama %d\n',Tramas(index));
            Tiempos(index) =toc;
            index=index+1;
            
        end
        flag2=1;
    end
    Dado=rand(1);
    if Dado>NR(1)
        fprintf('ACK recibido de la trama %d \n',Tramas(index-Ventana));
        
        fprintf('Transmitiendo trama %d \n',Tramas(index));
        if Tramas(index)==NumeroTramas
            flag=1;
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
        flag2=0;
    end
end
%Last 'W' Frames are dealt seperately
i=NumeroTramas-Ventana+1;
while (i<=NumeroTramas)
    Dado=rand(1);
    if Dado>NR(1)
        fprintf('Recibido ACK de trama %d\n',Tramas(i));
        i=i+1;
        
    else
        fprintf('Error al recibir ACK de la trama %d\n',Tramas(i));
        for j=i:NumeroTramas
            fprintf('Descartando la trama %d\n',Tramas(j));
        end
        for k=i:NumeroTramas
            fprintf('Transmitiendo trama %d\n',Tramas(k));
        end
    end
end
Contador(4)=Contador(1)-Contador(2);
