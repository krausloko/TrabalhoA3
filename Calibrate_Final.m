%Configuração MATLAB - opengl('save','software')
clear all
clc
close all
%% Seção 1

%Parte 1
%Load calibration images.
%Usuario inserior caminho para a pasta de imagens
caminho=input('Digite o caminho da pasta:','s')
%'C:\Users\Gabriel\Desktop\Visão Computacional\Trabalho 3\Images4' - cel
%C:\Users\Gabriel\Desktop\Visão Computacional\Trabalho 3\Images5 - pc
pasta=fullfile(caminho);
conjunto=imageDatastore(pasta);
tam=length(conjunto.Files)
%% Seção 2

%Parte 2 - Detect the checkerboard corners in the images.
disp('Detectando Quinas...')
[imagePoints,boardSize,imagesUsed] = detectCheckerboardPoints(conjunto.Files);
disp('Detectado!')
%Parte 3 - Find the camera parameters and plot positions
% Generate the world coordinates of the checkerboard corners in the pattern-centric coordinate system, with the upper-left corner at (0,0).
squareSize=input('Digite o tamanho do quadrado(mm):')
worldPoints=generateCheckerboardPoints(boardSize,squareSize);
% Calibrar câmera -> calcular parâmetros
disp('Calibrando...')
cameraParams = estimateCameraParameters(imagePoints, worldPoints);
disp('Calibrado!')
%% Seção 3 -Plots

%Plotar pontos encontrados no tabuleiro
for i = 1:2%tam
    figure
    I =imread(conjunto.Files{i,1});
    idisp(I);
    hold on;
    plot(imagePoints(:,1,i),imagePoints(:,2,i),'ro');
end

%Plotar Erros, Posição da câmera, Posição dos planos e Pontos Detectados
figure;
showReprojectionErrors(cameraParams);

figure;
showExtrinsics(cameraParams, 'PatternCentric');

figure;
showExtrinsics(cameraParams, 'CameraCentric');
%% Seção 4
video = webcam();
figure

%Tipo de Desenho
desenho=input('escolha desenho:')

if(desenho==1 || desenho==2)
    %Coordenadas de referência para desenho do cubo
    lado=input('Digite o tamanho do lado :')
    x=input('Digite referência X :')
    y=input('Digite referência Y :')
    %Escolha da Cor
    cor=input('Digite a cor:','s')
end

if(desenho==3 || desenho==4)
    %Angulo de rotação - falta definição
    teta=input('Digite o angulo Teta :')
    %Tipo de traço - cor e estilo
    tipo=input('Digite tipo de traço:','s')
end

 tempo=input('Digite tempo:')

%% Seção 5

%Cubo
if(desenho==1)
     tic
    while (true)
        
        originalImage =(snapshot(video));
        %Undistort image.
        undistortedImage = undistortImage(originalImage, cameraParams);
        idisp(undistortedImage)
        hold on;
        % Encontrar pontos na nova imagem
        [imagePoints2,boardSize2,imagesUsed2] = detectCheckerboardPoints(undistortedImage);
        
        if size(imagePoints2,1) == size(worldPoints,1)
            %Calcular Matriz da câmera - parâmetros extrinsecos e intrinsecos
            [rotationMatrix, translationVector] = extrinsics(imagePoints2,worldPoints, cameraParams);
            C = cameraMatrix(cameraParams,rotationMatrix,translationVector);
            C = C';
            
            p1=C*[x;y;0;1];
            p2=C*[x+lado;y;0;1];
            p3=C*[x+lado;y+lado;0;1];
            p4=C*[x;y+lado;0;1];
            p5=C*[x;y;lado;1];
            p6=C*[x+lado;y;lado;1];
            p7=C*[x+lado;y+lado;lado;1];
            p8=C*[x;y+lado;lado;1];
            
            vetor=[p1(1)/p1(3) p2(1)/p2(3) p3(1)/p3(3) p4(1)/p4(3) p1(1)/p1(3)]
            vetory=[p1(2)/p1(3) p2(2)/p2(3) p3(2)/p3(3) p4(2)/p4(3) p1(2)/p1(3)]
            vetorx2=[p5(1)/p5(3) p6(1)/p6(3) p7(1)/p7(3) p8(1)/p8(3) p5(1)/p5(3)]
            vetory2=[p5(2)/p5(3) p6(2)/p6(3) p7(2)/p7(3) p8(2)/p8(3) p5(2)/p5(3)]
            vetorx3=[p1(1)/p1(3) p5(1)/p5(3) p6(1)/p6(3) p2(1)/p2(3) p3(1)/p3(3) p7(1)/p7(3) p8(1)/p8(3) p4(1)/p4(3)]
            vetory3=[p1(2)/p1(3) p5(2)/p5(3) p6(2)/p6(3) p2(2)/p2(3) p3(2)/p3(3) p7(2)/p7(3)  p8(2)/p8(3) p4(2)/p4(3)]
            plot(vetor,vetory,cor,vetorx2,vetory2,cor,vetorx3,vetory3,cor)
            
            
        end
        
        
        disp(toc)
        disp(tempo)
        if(toc>tempo)
            disp('FIM!!!')
            close all
            break; 

         end
         
        
    end
   
end



%Cubo cheio
if(desenho==2)
    tic
    while (true)
        
        originalImage = (snapshot(video));
        %Undistort image.
        undistortedImage = undistortImage(originalImage, cameraParams);
        idisp(undistortedImage)
        hold on;
        % Encontrar pontos na nova imagem
        [imagePoints2,boardSize2,imagesUsed2] = detectCheckerboardPoints(undistortedImage)
        
        if size(imagePoints2,1) == size(worldPoints,1)
            
            %Calcular Matriz da câmera - parâmetros extrinsecos e intrinsecos
            [rotationMatrix, translationVector] = extrinsics(imagePoints2,worldPoints, cameraParams);
            C = cameraMatrix(cameraParams,rotationMatrix,translationVector);
            C = C';
            
            p1=C*[x;y;0;1];
            p2=C*[x+lado;y;0;1];
            p3=C*[x+lado;y+lado;0;1];
            p4=C*[x;y+lado;0;1];
            p5=C*[x;y;lado;1];
            p6=C*[x+lado;y;lado;1];
            p7=C*[x+lado;y+lado;lado;1];
            p8=C*[x;y+lado;lado;1];
            
            % X  = [5 2 1 2];
            % seqlengths = diff([0, find(diff(X)), numel(X)]);  %calculate the length of each continuous sequence
            % cor = X(cumsum(seqlengths));  %extract the colour corresponding to each sequence
            
            fill([p2(1)/p2(3) p6(1)/p6(3) p5(1)/p5(3) p1(1)/p1(3)],[p2(2)/p2(3) p6(2)/p6(3) p5(2)/p5(3) p1(2)/p1(3)],cor)%fundo
            fill([p1(1)/p1(3) p4(1)/p4(3) p8(1)/p8(3) p5(1)/p5(3)],[p1(2)/p1(3) p4(2)/p4(3) p8(2)/p8(3) p5(2)/p5(3)],cor)%l1
            fill([p1(1)/p1(3) p2(1)/p2(3) p3(1)/p3(3) p4(1)/p4(3)],[p1(2)/p1(3) p2(2)/p2(3) p3(2)/p3(3) p4(2)/p4(3)],cor)%tras
            fill([p2(1)/p2(3) p6(1)/p6(3) p7(1)/p7(3) p3(1)/p3(3)],[p2(2)/p2(3) p6(2)/p6(3) p7(2)/p7(3) p3(2)/p3(3)],cor)%l2
            fill([p5(1)/p5(3) p6(1)/p6(3) p7(1)/p7(3) p8(1)/p8(3)],[p5(2)/p5(3) p6(2)/p6(3) p7(2)/p7(3) p8(2)/p8(3)],cor)
            fill([p3(1)/p3(3) p4(1)/p4(3) p8(1)/p8(3) p7(1)/p7(3)],[p3(2)/p3(3) p4(2)/p4(3) p8(2)/p8(3) p7(2)/p7(3)],cor)
            
            
            
        end
        
           disp(toc)
        disp(tempo)
        if(toc>tempo)
                        disp('FIM!!!')
            close all
            break; 

         end
         
    end
    
end

%Cavalo
if(desenho==3)
    p = 0;
    vetor = 0;
    % Read a point cloud.
    ptCloud = pcread('horse.ply');
    
    %exemplo - Create a transform object with a 45 degrees rotation along the z -axis.
    A = [cos(teta) sin(teta) 0 0;-sin(teta) cos(teta) 0 0;0 0 1 0;0 0 0 1];
    
    tform = affine3d(A);
    % Transform the point cloud.
    ptCloudTformed = pctransform(ptCloud,tform);
    pontosNuvem= (ptCloudTformed.Location)*1e3;
    
    
    while (true)
        
        originalImage = (snapshot(video));
        %Undistort image.
        undistortedImage = undistortImage(originalImage, cameraParams);
        idisp(undistortedImage)
        hold on;
        % Encontrar pontos na nova imagem
        [imagePoints2,boardSize2,imagesUsed2] = detectCheckerboardPoints(undistortedImage);
        
        if size(imagePoints2,1) == size(worldPoints,1)
            
            %Calcular Matriz da câmera - parâmetros extrinsecos e intrinsecos
            [rotationMatrix, translationVector] = extrinsics(imagePoints2,worldPoints, cameraParams);
            C = cameraMatrix(cameraParams,rotationMatrix,translationVector);
            C = C';
            
            % Plot the transformed point cloud.
            aux=1;
            for i=1:length(pontosNuvem)
                if mod(i,100)==0
                    p = C*[pontosNuvem(i,1);pontosNuvem(i,3);pontosNuvem(i,2);1];
                    vetor(aux,1) = p(1)/p(3);
                    vetor(aux,2) = p(2)/p(3);
                    aux = aux+1;
                end
            end
            
            plot(vetor(:,1),vetor(:,2),tipo);
        end
        
           disp(toc)
        disp(tempo)
        if(toc>tempo)
                        disp('FIM!!!')
            close all
            break; 

         end
            
    end
    
    
end

%Leão
if(desenho==4)
    tic
    
    p = 0;
    vetor = 0;
    
    %Read a point cloud.
    ptCloud = pcread('LionMatching.ply');
    
    %Transformação de Translação, Rotação e Tamanho
    A = [cos(teta) sin(teta) 0 0;-sin(teta) cos(teta) 0 0;0 0 1 0;0 0 0 1];
    tform = affine3d(A);
    % Transform the point cloud.
    ptCloudTformed = pctransform(ptCloud,tform);
    pontosNuvem = (ptCloudTformed.Location);
    
    while (true)
        %Nova Imagem
        originalImage = (snapshot(video));
        %Undistort image.
        undistortedImage = undistortImage(originalImage, cameraParams);
        idisp(undistortedImage)
        hold on;
        % Encontrar pontos na nova imagem
        [imagePoints2,boardSize2,imagesUsed2] = detectCheckerboardPoints(undistortedImage);
        
        if size(imagePoints2,1) == size(worldPoints,1)
            
            %Calcular Matriz da câmera - parâmetros extrinsecos e intrinsecos
            [rotationMatrix, translationVector] = extrinsics(imagePoints2,worldPoints, cameraParams);
            C = cameraMatrix(cameraParams,rotationMatrix,translationVector);
            C = C';
            
            % Plot the transformed point cloud.
            aux=1;
            for i=1:length(pontosNuvem)
                if mod(i,100)==0
                    p = C*[-pontosNuvem(i,1);pontosNuvem(i,3);-pontosNuvem(i,2);1];
                    vetor(aux,1) = p(1)/p(3);
                    vetor(aux,2) = p(2)/p(3);
                    aux = aux+1;
                end
            end
            
            plot(vetor(:,1),vetor(:,2),tipo);
        end
        
           disp(toc)
        disp(tempo)
        if(toc>tempo)
                        disp('FIM!!!')
            close all
            break; 

         end
         
        
    end
    
    
end


%%
% p1=[0;0;0;1]
% figure
% plot3( [0  0  0;0  0  0; 0  0  1], [0  0  0; 0  1  0; 0  0  0], [1  0  0; 0  0  0; 0  0  0], 'p-r')
% grid on
% axis([-1 2    -1 2    -1 2])
% axis equal

% K1=cameraParams.IntrinsicMatrix;
% f=cameraParams.FocalLength(1);
% K2=[f zeros(1,3);0 f zeros(1,2);zeros(1,2) 1 0];
% ksi=[rotationMatrix translationVector';zeros(1,3) 1]^-1
% pontos=K1*K2*ksi*[zeros(4,1)]

%fill([p5(1)/p5(3) p6(1)/p6(3) p7(1)/p7(3) p8(1)/p8(3)],[p5(2)/p5(3) p6(2)/p6(3) p7(2)/p7(3) p8(2)/p8(3)],'k')
%plot(pontos2d(1),pontos2d(2),'ro')

% Rotate 3-D Point Cloud
