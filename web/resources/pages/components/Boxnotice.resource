*** Settings ***
Documentation    Ações e elementos do componente de caixa de notificação

Library    Browser

*** Keywords ***
Notice should be
    [Arguments]        ${target}

    ${elements}    Set Variable    css=form .notice

    wait for elements state
    ...    ${elements}
    ...    visible    5

    Get Text    ${elements}    equal    ${target}