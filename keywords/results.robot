*** Settings ***
Library           SeleniumLibrary
Library           String
Resource          ../variables/selectors.robot

*** Variables ***

${ITEM_CODE}    LVL20156634
${SEARCH_RESULT_ITEM}    //div[contains(@id,'CC-product-list-name-${ITEM_CODE}')]
${ITEM_CODE_LABEL}    //span[@id = 'span-productId' and text()='${ITEM_CODE}']
${ADD_TO_CART_BUTTON}    //span[@id='cc-prodDetails-addToCart']

*** Keywords ***

Selecionar Ítem
    [Arguments]    ${item}
    Click Element    ${item}
    Wait Until Element Is Not Visible    ${LIVELO_SPINNER}    ${TIMEOUT}
    Wait Until Element Is Visible    ${ADD_TO_CART_BUTTON}    ${TIMEOUT}
