*** Settings ***
Library           SeleniumLibrary
Library           String
Resource          ../variables/selectors.robot

*** Keywords ***

Mudar Quantidade
    [Arguments]    ${operação}    ${quantidade}

    ${button}=    Run Keyword If    '${operação}' == '+'    Set Variable    ${PLUS_BUTTON}
    ...           ELSE IF           '${operação}' == '-'    Set Variable    ${MINUS_BUTTON}
    ...           ELSE    FAIL    Operação ${operação} inválida!
    
    ${quantidade_antes}=    Get Text    ${QTD_ITEM}
    
    FOR    ${i}    IN RANGE    ${quantidade}
        Click Element    ${button}
        Wait Until Element Is Not Visible    ${LIVELO_SPINNER}    ${TIMEOUT}
        Wait Until Element Is Visible    ${SUB_TOTAL_ITEM}    ${TIMEOUT}
    END

    ${quantidade_depois}=    Get Text    ${QTD_ITEM}

    ${quantidade_esperada}=    Evaluate    ${quantidade_antes} ${operação} ${quantidade}

    Should Be Equal As Numbers    ${quantidade_depois}     ${quantidade_esperada}
