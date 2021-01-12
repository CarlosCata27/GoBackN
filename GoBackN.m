close all;
clear;
clc
%Entrada de variables
Tramas=input('Inserte su numero de tramas: ');
Ventana=input('Inserte el tamaño de la ventana: ');

%Nos aseguramos de que la informacion sea correcta desdee un principio
while Ventana>=Tramas
  Ventana=input('La ventana no puede ser mas grande que el numero de tramas\nIngresa nuevamente el tamaño de la ventana: ');
end

%Declaramos variables a utilizar en el proceso
Tramasenviadas=0;
TramasenVentana=0;
TramasnoEnviadas=Tramas;
index=1;
Bandera=0;
Bandera2=0;

%Realizamos un vector para conocer como se transmitiran las tramas
VectorTramas=1:Tramas;

%Iniciamos con el protocolo
while Bandera==0
  if Bandera2==0
    %Transmitimos el numero correspondiente de tramas con el de la ventana
    for i=1:Ventana
      fprintf('Transmitiendo trama %d\n',VectorTramas(index));
      TramasnoEnviadas = TramasnoEnviadas-1;
      TramasenVentana = TramasenVentana+1;
      %Grafica(Tramasenviadas,TramasenVentana-Tramasenviadas,TramasnoEnviadas)
      index=index+1;
    end
    %Signalling the end of the window
    Bandera2=1;
  end
  %Setting the noise in the station
  Dado = randi(10,1,1);
  %Event of frame acknowledged
  if Dado>2
    fprintf('Ackowledgement of Frame %d Received\n',VectorTramas(index-Ventana));
    Tramasenviadas = Tramasenviadas+1;
    %Grafica(Tramasenviadas,TramasenVentana-Tramasenviadas,TramasnoEnviadas)

    %Checking corner case
    if index==Tramas+1
      fprintf('Frame %d Transmitted\n',VectorTramas(index-1));
    else
      fprintf('Frame %d Transmitted\n',VectorTramas(index));
    end

    TramasenVentana = TramasenVentana+1;
    TramasnoEnviadas = TramasnoEnviadas-1;
    %Grafica(Tramasenviadas,TramasenVentana-Tramasenviadas,TramasnoEnviadas)
    if index==Tramas + 1 || VectorTramas(index) == Tramas
      Bandera=1;
    end
    index=index+1;

  %No acknowledgement
  else
    Dado = randi(10,1,1);
    %If corrupted frame received
    if Dado > 5
      fprintf('Corrupted Frame %d Received\n',VectorTramas(index-Ventana));
    else
      fprintf('No Acknowledgement of Frame %d Received\n',VectorTramas(index-Ventana));
    end
    %Grafica(Tramasenviadas,TramasenVentana-Tramasenviadas,TramasnoEnviadas)

    %Discarding waiting frames
    for j=Ventana-1:-1:1
      fprintf('Frame %d Discarded\n',VectorTramas(index-Ventana+j));
      TramasenVentana=TramasenVentana-1;
      TramasnoEnviadas=TramasnoEnviadas+1;
      %Grafica(Tramasenviadas,TramasenVentana-Tramasenviadas,TramasnoEnviadas)
    end
    TramasenVentana=TramasenVentana-1;
    TramasnoEnviadas=TramasnoEnviadas+1;
    index=index-Ventana;
    Bandera2=0;
  end
end

%Last 'W' Frames are dealt seperately
i=Tramas-Ventana+1;

while (i<=Tramas)
  %Setting the noise in the station
  Dado = randi(10,1,1);
  %Acknowledgement of frames
  if Dado>3
    fprintf('ACK de la trama %d fue recibido\n',VectorTramas(i));
    Tramasenviadas = Tramasenviadas+1;
    %Grafica(Tramasenviadas,TramasenVentana-Tramasenviadas,TramasnoEnviadas)
    i=i+1;
  %Non Acknowledgement of frames
  else
    Dado = randi(10,1,1);
    %Si la trama recibida es erronea
    if Dado > 5
      fprintf('La trama %d es erronea\n',VectorTramas(i));
    else
      fprintf('No Acknowledgement of Frame %d Received\n',VectorTramas(i));
    end
    %Grafica(Tramasenviadas,TramasenVentana-Tramasenviadas,TramasnoEnviadas)
    for j=Tramas:-1:i+1
      fprintf('Trama %d descartada\n',VectorTramas(j));
      TramasenVentana=TramasenVentana-1;
      TramasnoEnviadas=TramasnoEnviadas+1;
      %Grafica(Tramasenviadas,TramasenVentana-Tramasenviadas,TramasnoEnviadas)
    end
    TramasenVentana=TramasenVentana-1;
    TramasnoEnviadas=TramasnoEnviadas+1;
    %Retransmitimos las tramas
    for k=i:Tramas
      fprintf('Trama %d Transmitted\n',VectorTramas(k));
      TramasenVentana = TramasenVentana+1;
      TramasnoEnviadas = TramasnoEnviadas-1;
      %Grafica(Tramasenviadas,TramasenVentana-Tramasenviadas,TramasnoEnviadas)
    end
  end
end

bar([Tramasenviadas 0 0 ;Tramasenviadas TramasenVentana-Tramasenviadas TramasnoEnviadas],'r');
grid on;
ylabel('Tramas Recibidas');
xlabel('Tramas Enviadas');