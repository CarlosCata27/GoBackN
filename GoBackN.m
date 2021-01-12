clc;
clear all;
NumeroTramas=1000;
Ventana=[3 5];
NR=[0.01 0.1];
Tiempos=zeros(1,NumeroTramas);
Contador=zeros(4);
Contador(1:4)=Protocolo(NR(1),Ventana(1),NumeroTramas);%Ventana 3 con NR de 0.01
Contador(5:8)=Protocolo(NR(1),Ventana(2),NumeroTramas);%Ventana 5 con NR de 0.01
Contador(9:12)=Protocolo(NR(2),Ventana(1),NumeroTramas);%Ventana 3 con NR de 0.1
Contador(13:16)=Protocolo(NR(2),Ventana(2),NumeroTramas);%Ventana 5 con NR de 0.1


