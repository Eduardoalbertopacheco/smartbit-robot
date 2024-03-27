*** Settings ***
Documentation        Suite de testes de login

Resource        ../resources/base.resource

Test Setup       Start session
Test Teardown    Finish session

*** Test Cases ***
Deve logar com CPF e IP

    ${data}    Get json fixture    login

    Insert Membership    ${data}

    Signin with document    ${data}[account][cpf]
    User is logged in

Não deve logar com cpf não cadastrado
    Signin with document  63368106317
    Popup have text
    ...    Acesso não autorizado! Entre em contato com a central de atendimento

Não deve logar com cpf inválido
    [Tags]    temp
    Signin with document  63368106318
    Popup have text
    ...    CPF inválido, tente novamente
    
