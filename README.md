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
 **Formas Desenhadas sobre o Tabuleiro**      
![fe1](https://user-images.githubusercontent.com/35512686/41882542-e131138a-78bf-11e8-82ab-eeb355721888.png)
![ge2](https://user-images.githubusercontent.com/35512686/41882543-e15d6d36-78bf-11e8-9375-7ad1f55e57d7.png)
## Requirements:
- Matlab R2016 ou mais recente
- Machine Vision Toolbox - Peter Corke
## License:
This toolbox is under the MIT License: http://opensource.org/licenses/MIT.
