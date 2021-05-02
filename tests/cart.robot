*** Settings ***
Documentation     Suite de testes para validar ações de carrinho

Resource          ../keywords/home.robot
Resource          ../keywords/results.robot
Resource          ../keywords/description.robot
Resource          ../keywords/cart.robot

Suite Setup    Set Selenium Speed    0.5
Test Teardown    Close Browser

*** Test Cases ***
Dado Que O Usuário Pesquisou Pelo Ítem E Clicou Adicionar, O Ítem Deve Ir Para O Carrinho
    [Documentation]    Usuário deve poder escolher ítens e adicionar ao carrinho
 
    Open Browser    ${LIVELO_WEBSITE}    ${BROWSER_NAME}    Usuário_1    ${CONTAINER}
    Wait Until Element Is Visible    ${LIVELO_ICON}    ${TIMEOUT}

    Pesquisar Ítem    ${SEARCH_TEXT}
    Wait Until Element Is Visible    ${SEARCH_RESULT_ITEM}    ${TIMEOUT}

    Selecionar Ítem    ${SEARCH_RESULT_ITEM}
    Wait Until Element Is Visible    ${ITEM_CODE_LABEL}    ${TIMEOUT}
    Wait Until Element Is Visible    ${ITEM_VALUE}    ${TIMEOUT}

    ${valor_unitario}=    Pegar Valor Do Elemento    ${ITEM_VALUE}

    Adicionar Ao Carrinho

    ${sub_total}=    Pegar Valor Do Elemento    ${SUB_TOTAL_ITEM}

    Should Be Equal    ${valor_unitario}    ${sub_total}

Dado Que Usuário Adicionou Um Ítem Ao Carrinho, Deve Poder Aumentar A Quantidade
    [Documentation]    Usuário deve poder adicionar ítens ao carrinho e mudar quantidade
 
    Open Browser    ${LIVELO_WEBSITE}    ${BROWSER_NAME}    Usuário_2    ${CONTAINER}
    Wait Until Element Is Visible    ${LIVELO_ICON}    ${TIMEOUT}

    Pesquisar Ítem    ${SEARCH_TEXT}
    Wait Until Element Is Visible    ${SEARCH_RESULT_ITEM}    ${TIMEOUT}

    Selecionar Ítem    ${SEARCH_RESULT_ITEM}
    Wait Until Element Is Visible    ${ITEM_CODE_LABEL}    ${TIMEOUT}
    Wait Until Element Is Visible    ${ITEM_VALUE}    ${TIMEOUT}

    ${valor_unitario}=    Pegar Valor Do Elemento    ${ITEM_VALUE}

    Adicionar Ao Carrinho

    Mudar Quantidade    +    3

    ${sub_total}=    Pegar Valor Do Elemento    ${SUB_TOTAL_ITEM}

    ${total}=    Evaluate    ${valor_unitario} * 4

    Should Be Equal As Numbers    ${total}    ${sub_total}

Dado Que Usuário Adicionou Quantidade 2 Ou Mais De Um Ítem Ao Carrinho, Deve Poder Reduzir A Quantidade
    [Documentation]    Usuário deve poder reduzir quantidade de um ítem
 
    Open Browser    ${LIVELO_WEBSITE}    ${BROWSER_NAME}    Usuário_2    ${CONTAINER}
    Wait Until Element Is Visible    ${LIVELO_ICON}    ${TIMEOUT}

    Pesquisar Ítem    ${SEARCH_TEXT}
    Wait Until Element Is Visible    ${SEARCH_RESULT_ITEM}    ${TIMEOUT}

    Selecionar Ítem    ${SEARCH_RESULT_ITEM}
    Wait Until Element Is Visible    ${ITEM_CODE_LABEL}    ${TIMEOUT}
    Wait Until Element Is Visible    ${ITEM_VALUE}    ${TIMEOUT}

    ${valor_unitario}=    Pegar Valor Do Elemento    ${ITEM_VALUE}

    Adicionar Ao Carrinho

    Mudar Quantidade    +    2
    Mudar Quantidade    -    1

    ${sub_total}=    Pegar Valor Do Elemento    ${SUB_TOTAL_ITEM}

    ${total}=    Evaluate    ${valor_unitario} * 2

    Should Be Equal As Numbers    ${total}    ${sub_total}

Dado Que Usuário Adicionou Um Ítem Ao Carrinho, Não Deve Poder Reduzir A Quantidade
    [Documentation]    Ítem recém adicionado ao carrinho vai com quantidade 1 e não pode ser reduzido
 
    Open Browser    ${LIVELO_WEBSITE}    ${BROWSER_NAME}    Usuário_2    ${CONTAINER}
    Wait Until Element Is Visible    ${LIVELO_ICON}    ${TIMEOUT}

    Pesquisar Ítem    ${SEARCH_TEXT}
    Wait Until Element Is Visible    ${SEARCH_RESULT_ITEM}    ${TIMEOUT}

    Selecionar Ítem    ${SEARCH_RESULT_ITEM}
    Wait Until Element Is Visible    ${ITEM_CODE_LABEL}    ${TIMEOUT}
    Wait Until Element Is Visible    ${ITEM_VALUE}    ${TIMEOUT}

    ${valor_unitario}=    Pegar Valor Do Elemento    ${ITEM_VALUE}

    Adicionar Ao Carrinho

    ${conseguiu_reduzir}=    Run Keyword And Return Status    Mudar Quantidade    -    1
    Should Not Be True    ${conseguiu_reduzir}

Dado Que O Usuário Apenas Acessou O Site, O Carrinho Deve Estar Vazio
    [Documentation]    Carrinho deve estar vazio para o usuário quando ele acaba de entrar no site
 
    Open Browser    ${LIVELO_WEBSITE}    ${BROWSER_NAME}    Usuário_3    ${CONTAINER}
    Wait Until Element Is Visible    ${LIVELO_ICON}    ${TIMEOUT}
    Wait Until Element Is Visible    ${CART_BUTTON}    ${TIMEOUT}
    
    Click Element    ${CART_BUTTON}
    Wait Until Element Is Visible    ${EMPTY_CART_MESSAGE}    ${TIMEOUT}
