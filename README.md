# Automação Livelo

Automação de testes sobre o site [Livelo](livelo.com.br) utilizando [Robot Framework](https://robotframework.org/).

# Pré requisitos

* Sistema Operacional Linux Ubuntu
* Docker instalado

# Execução
* Navegue pelo terminal até a pasta raíz do projeto `automacao-livelo`
* Rode o seguinte comando: `./run.sh ` 
* <b>IMPORTANTE:</b> Caso seu docker exija acesso root, será necessário realizar uma das duas opções abaixo:
  1. Inserir `sudo` na chamada de execução dos testes: `sudo ./run.sh`
  2. Dar permissão não root para o docker: 
      * `sudo snap install`
      * `sudo group add docker`
      * `sudo usermod -aG docker $USER`
      * Reiniciar o computador

# Resultados

Os resultados de cada teste são exibidos no terminal durante a execução. Além disso, será gerado um relatório `/logs/log.html` com os resultados de cada passo dos testes e imagens quando ocorrer falhas.

# Estrutura

* O processo do Robot executa dentro de um container Docker, cuja imagem já contem instalado tudo que é necessário para Robot. 
* O Navegador também executa em um container separado, já com o Chrome e ChromeDriver instalados.
* É criada uma rede interna para conectar os containers e permitir que o Robot interaja com o navegador, intermediado pelo Selenium e Driver. Nesse tipo de organização seria possível expandir para mais containers de browser numa execução paralela de testes.
* Ao executar o script `./run.sh` as imagens são geradas e em seguida os containers são iniciados automaticamente, conectados pela rede, os testes começam a rodar, e ao final, a estrutura de containers é desfeita sem deixar nada para trás.
* Caso a execução do script seja interrompido, ele finalizará os containers automaticamente sem deixar nada para trás.
