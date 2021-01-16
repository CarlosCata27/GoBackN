clc;
clear;
close all;
NumeroTramas=100000;
Ventana=[3 5];
NR=[0.01 0.1];
Contador=zeros(4);
Titulo1=["Ventana 3 con NR=0.01","Enviadas           Perdidas           Retransmitidas           Reconocidas"];
Titulo2=["Ventana 5 con NR=0.01","Enviadas           Perdidas           Retransmitidas           Reconocidas"];
Titulo3=["Ventana 3 con NR=0.1","Enviadas           Perdidas           Retransmitidas           Reconocidas"];
Titulo4=["Ventana 5 con NR=0.1","Enviadas           Perdidas           Retransmitidas           Reconocidas"];
[Contador(1:4),Tiempos1]=Protocolo(NR(1),Ventana(1),NumeroTramas);%Ventana 3 con NR de 0.01
Grafica(Contador(1:4),Titulo1)
[Contador(5:8),Tiempos2]=Protocolo(NR(1),Ventana(2),NumeroTramas);%Ventana 5 con NR de 0.01
Grafica(Contador(5:8),Titulo2)
[Contador(9:12),Tiempos3]=Protocolo(NR(2),Ventana(1),NumeroTramas);%Ventana 3 con NR de 0.1
Grafica(Contador(9:12),Titulo3)
[Contador(13:16),Tiempos4]=Protocolo(NR(2),Ventana(2),NumeroTramas);%Ventana 5 con NR de 0.1
Grafica(Contador(13:16),Titulo4)