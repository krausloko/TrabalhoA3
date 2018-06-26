# Trabalho A3 - Calcular posição de um tabuleiro e desenhar formas sobre o mesmo.

Terceiro Trabalho da disciplina BLU3040 - Visao Computacional em Robótica, UFSC - Campus Blumenau

## Function:
A função desevolvida recebe um conjunto de imagens de um tabuleiro e realiza a calibração da câmera, em seguida a posição de novas imagens da mesma câmera pode ser calculada e formas podem ser desenhadas sobre uma posição do mesmo tabuleiro.

## Quick start:
<p>1- Fazer download completo do repositório.<p>
<p>2- Adicionar a função 'Calibrate_Final.m' e as imagens na pasta do Matlab.<p>
<p>3- Executar a função 'Calibrate_Final.m'.<p>
<p>4- Observar na janela aberta a forma desenhada.<p>

## How it works:
**Parte 1: Inserir pasta com as imagens do Tabuleiro para a calibração**  
Conjunto de imagens é utilizado para  calibração.  
**Parte 2: Detectar Padrão do Tabuleiro**  
Detectar as quinas do tabuleiro e calcular parâmetros internos da câmera.  
**Parte 3: Plotar Informações**  
Plot das posições do tabuleiro ou da câmera, e do erro de reprojeção.  
**Parte 4: Usuário Escolher Formas e Tipo do Desenho**  
Definir tipo de desenho, cor e tamanho.  
**Parte 5: Plotar Formas**  
Loop para desenhar formas sobre a imagem do tabuleiro.  
 
Para ver o embasamento teórico e explicação detalhada do código basta ler o arquivo 'Relatório A3 - Visão Computacional.pdf'

## Results:
**Placa**  
![placagit1](https://user-images.githubusercontent.com/35512686/40154965-a1e3be34-5967-11e8-8e91-1cbf69175b18.png)  
 **Placa com Máscara**  
![placagit2](https://user-images.githubusercontent.com/35512686/40154966-a20e5324-5967-11e8-9d52-14dfa4f0ed1c.png)  
 **Blobs Selecionados**    
 - Blobs Letras:  
![placagit3](https://user-images.githubusercontent.com/35512686/40154968-a2390826-5967-11e8-987e-3676b8f1e2a4.png)  
 - Blobs Números:  
![placagit4](https://user-images.githubusercontent.com/35512686/40154969-a2657122-5967-11e8-9d27-fd07f9cd9644.png)  
 - Blobs Estado:  
![placagit5](https://user-images.githubusercontent.com/35512686/40155083-237f0476-5968-11e8-9cac-97faa0e40040.png)  
 - Blobs Cidade:  
![placagit6](https://user-images.githubusercontent.com/35512686/40155084-23a9b392-5968-11e8-8f5b-f7a2d7a1a93f.png)  
## Requirements:
- Matlab R2016 ou mais recente
- Machine Vision Toolbox - Peter Corke
## License:
This toolbox is under the MIT License: http://opensource.org/licenses/MIT.
