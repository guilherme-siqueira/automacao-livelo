*** Settings ***
Library           SeleniumLibrary
Library           String
Library           Collections
Resource          ../variables/selectors.robot

*** Keywords ***

Pegar Sub Total
    ${sub_total}=    Pegar Valor Do Elemento    ${SUB_TOTAL_ITEM}
    [Return]    ${sub_total}

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
        Wait Until Element Is Visible    ${QTD_ITEM}
    END

    ${quantidade_depois}=    Get Text    ${QTD_ITEM}
    ${quantidade_esperada}=    Evaluate    ${quantidade_antes} ${operação} ${quantidade}

    Should Be Equal As Numbers    ${quantidade_depois}     ${quantidade_esperada}

Verificar Valor Total
    [Arguments]    ${valor_unitario}     ${quantidade}    ${total_esperado}

    ${total_calculado}=    Evaluate    ${valor_unitario} * ${quantidade}
    ${total_bateu}=    Evaluate    ${total_calculado} == ${total_esperado}
    
    Return From Keyword    '${total_bateu}' == 'True'

    # se o valor é diferente, é porque houve uma mudança no momento do teste
    Wait Until Element Is Visible    ${VALUE_CHANGE_MSG}
