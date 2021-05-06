*** Settings ***
Library           SeleniumLibrary
Library           String
Library           Collections
Resource          ../variables/selectors.robot

*** Keywords ***

Selecionar Ítem
    [Arguments]    ${texto_chave}

    ${codigo_produto}=    Get From Dictionary    ${PRODUCT_OPTIONS}    ${texto_chave}

    ${item}=    Replace String    ${SEARCH_RESULT_ITEM}    $$    ${codigo_produto}
    Wait Until Element Is Visible    ${item}    ${TIMEOUT}

    Click Element    ${item}
    Wait Until Element Is Not Visible    ${LIVELO_SPINNER}    ${TIMEOUT}
    Wait Until Element Is Visible    ${ADD_TO_CART_BUTTON}    ${TIMEOUT}

    ${resultado}=    Replace String    ${ITEM_CODE_LABEL}    $$    ${codigo_produto}
    Wait Until Element Is Visible    ${resultado}    ${TIMEOUT}

    Wait Until Element Is Visible    ${ITEM_VALUE}    ${TIMEOUT}
