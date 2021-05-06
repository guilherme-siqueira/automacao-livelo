*** Settings ***
Documentation     Suite de testes para validar ações de carrinho

Resource          ../keywords/home.robot
Resource          ../keywords/results.robot
Resource          ../keywords/description.robot
Resource          ../keywords/cart.robot

Suite Setup       Set Selenium Speed    0.5
Test Setup        Abrir Livelo Home Page
Test Teardown     Close Browser

*** Test Cases ***
Dado Que O Usuário Pesquisou Pelo Ítem E Clicou Adicionar, O Ítem Deve Ir Para O Carrinho
    [Documentation]    Usuário deve poder escolher ítens e adicionar ao carrinho
 
    Pesquisar Ítem    aspirador robo multilaser
    Selecionar Ítem    aspirador robo multilaser
    ${valor_unitario}=    Pegar Valor Unitário
    Adicionar Ao Carrinho
    ${sub_total}=    Pegar Sub Total
    Verificar Valor Total    ${valor_unitario}    1    ${sub_total}

Dado Que Usuário Adicionou Um Ítem Ao Carrinho, Deve Poder Aumentar A Quantidade
    [Documentation]    Usuário deve poder adicionar ítens ao carrinho e mudar quantidade
 
    Pesquisar Ítem    celular samsung
    Selecionar Ítem    celular samsung
    ${valor_unitario}=    Pegar Valor Unitário
    Adicionar Ao Carrinho
    Mudar Quantidade    +    3
    ${sub_total}=    Pegar Sub Total
    Verificar Valor Total    ${valor_unitario}    4    ${sub_total}

Dado Que Usuário Adicionou Quantidade 2 Ou Mais De Um Ítem Ao Carrinho, Deve Poder Reduzir A Quantidade
    [Documentation]    Usuário deve poder reduzir quantidade de um ítem
 
    Pesquisar Ítem    smart tv
    Selecionar Ítem    smart tv
    ${valor_unitario}=    Pegar Valor Unitário
    Adicionar Ao Carrinho
    Mudar Quantidade    +    2
    Mudar Quantidade    -    1
    ${sub_total}=    Pegar Sub Total
    Verificar Valor Total    ${valor_unitario}    2    ${sub_total}

Dado Que Usuário Adicionou Um Ítem Ao Carrinho, Não Deve Poder Reduzir A Quantidade
    [Documentation]    Ítem recém adicionado ao carrinho vai com quantidade 1 e não pode ser reduzido
 
    Pesquisar Ítem    notebook hp intel core
    Selecionar Ítem    notebook hp intel core
    ${valor_unitario}=    Pegar Valor Unitário
    Adicionar Ao Carrinho
    ${conseguiu_reduzir}=    Run Keyword And Return Status    Mudar Quantidade    -    1
    Should Not Be True    ${conseguiu_reduzir}

Dado Que O Usuário Apenas Acessou O Site, O Carrinho Deve Estar Vazio
    [Documentation]    Carrinho deve estar vazio para o usuário quando ele acaba de entrar no site
 
    Wait Until Element Is Visible    ${CART_BUTTON}    ${TIMEOUT}
    Click Element    ${CART_BUTTON}
    Wait Until Element Is Visible    ${EMPTY_CART_MESSAGE}    ${TIMEOUT}
