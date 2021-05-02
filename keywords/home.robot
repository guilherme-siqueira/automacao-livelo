*** Settings ***
Library           SeleniumLibrary
Library           String
Resource          ../variables/selectors.robot

*** Keywords ***

Pesquisar Ítem
    [Arguments]    ${texto}
    Wait Until Element Is Visible    ${SEARCH_INPUT}    ${TIMEOUT}
    Input Text    ${SEARCH_INPUT}    ${texto}
    Click Element    ${SEARCH_BUTTON}
    Wait Until Element Is Not Visible    ${LIVELO_SPINNER}    ${TIMEOUT}
