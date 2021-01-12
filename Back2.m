clc;
clear all;
NumeroTramas=1000;
Ventana=[3,5];
index=1;
flag=0;
flag2=0;
Tramas=1:NumeroTramas;
ventana=1;
while flag==0
    if flag2==0
    %Transmitting The Frames In A Window
        for i=1:1:Ventana()
            fprintf('Transmitiendo trama %d\n',Tramas(index));
            index=index+1;
        end
        flag2=1;
    end
    s=randi(10,1,1);
    if s>3
        fprintf('PAK of Frame %d Received\n',Tramas(index-Ventana));
        fprintf('Frame %d Transmitted\n',Tramas(index));
        if Tramas(index)==NumeroTramas
            flag=1;
        end
        index=index+1;
    else
        fprintf('NAK Of Frame %d Received\n',Tramas(index-Ventana));
        for j=0:Ventana-1
            fprintf('Frame %d Discarded\n',Tramas(index-Ventana+j));
        end
        index=index-Ventana;
        flag2=0;
    end
end
%Last 'W' Frames are dealt seperately
i=NumeroTramas-Ventana+1;
while (i<=NumeroTramas)
    s=randi(10,1,1);
    if s>4
        fprintf('Rebicido ACK de trama %d\n',Tramas(i));
        i=i+1;
    else
        fprintf('Error al recibir ACK de la trama %d\n',Tramas(i));
        for j=i:NumeroTramas
            fprintf('Descartando la trama %d\n',Tramas(j));
        end
        for k=i:NumeroTramas
            fprintf('Frame %d Transmitted\n',Tramas(k));
        end
    end
end