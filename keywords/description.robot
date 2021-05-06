*** Settings ***
Library           SeleniumLibrary
Library           String
Library           Collections
Resource          ../variables/selectors.robot

*** Keywords ***
Pegar Valor Do Elemento
    [Arguments]    ${seletor}
    ${texto}=    Get Text    ${seletor}
    ${palavras}=    Split String    ${texto}    ${SPACE}
    Capture Page Screenshot
    [Return]    ${palavras}[0]

Pegar Valor Unitário
    ${valor_unitário}=    Pegar Valor Do Elemento    ${ITEM_VALUE}
    [Return]    ${valor_unitário}

Adicionar Ao Carrinho
    Click Element    ${ADD_TO_CART_BUTTON}
    Wait Until Element Is Not Visible    ${LIVELO_SPINNER}    ${TIMEOUT}
    Wait Until Element Is Visible    ${SUB_TOTAL_ITEM}    ${TIMEOUT}
    Wait Until Element Is Visible    ${PLUS_BUTTON}    ${TIMEOUT}
