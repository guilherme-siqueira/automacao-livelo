*** Settings ***
Library           SeleniumLibrary
Library           String
Library           Collections
Resource          ../variables/selectors.robot

*** Keywords ***
Abrir Livelo Home Page
    [Arguments]    ${usuário_especifico}=usuário
    Open Browser    ${LIVELO_WEBSITE}    ${BROWSER_NAME}    ${usuário_especifico}    ${CONTAINER}
    Wait Until Element Is Visible    ${LIVELO_ICON}    ${TIMEOUT}

Pesquisar Ítem
    [Arguments]    ${texto_chave}
    Wait Until Element Is Visible    ${SEARCH_INPUT}    ${TIMEOUT}
    Input Text    ${SEARCH_INPUT}    ${texto_chave}
    Click Element    ${SEARCH_BUTTON}
    Wait Until Element Is Not Visible    ${LIVELO_SPINNER}    ${TIMEOUT}

    ${codigo_produto}=    Get From Dictionary    ${PRODUCT_OPTIONS}    ${texto_chave}

    ${resultado}=    Replace String    ${SEARCH_RESULT_ITEM}    $$    ${codigo_produto}
    Wait Until Element Is Visible    ${resultado}    ${TIMEOUT}
