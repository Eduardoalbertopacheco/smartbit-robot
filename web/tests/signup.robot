*** Settings ***
Documentation        Cenários de testes de pré-cadastro de clientes

Resource        ../resources/Base.resource

Test Setup       Start session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve iniciar o cadastro de cliente
    [Tags]    smoke

    ${account}    Create Dictionary
    ...    name=Pacheco Eduardo
    ...    email=pacheco@gmail.com
    ...    cpf=02659415129

    Delete Account By Email    ${account}[email]

    Submit signup form    ${account}
    Verify welcome message

# Campo Nome deve ser obrigatório
#    [Tags]     required

#     ${account}       Create Dictionary
#     ...    name=${EMPTY}
#     ...    email=edu.teste@teste.com.br
#     ...    cpf=99306649045
    
#     Submit signup form     ${account}
#     Notice should be        Por favor informe o seu nome completo

# Campo Email deve ser obrigatório
#    [Tags]     required

#     ${account}       Create Dictionary
#     ...    name=Eduardo Fercanchoux
#     ...    email=${EMPTY}
#     ...    cpf=99306649045
    
#     Submit signup form     ${account}
#     Notice should be        Por favor, informe o seu melhor e-mail

# Campo CPF deve ser obrigatório
#    [Tags]     required

#    ${account}       Create Dictionary
#     ...    name=Eduardo Fercanchoux
#     ...    email=edu.teste@teste.com.br
#     ...    cpf=${EMPTY}

#     Submit signup form     ${account}
#     Notice should be        Por favor, informe o seu CPF

# Email no formato inválido
#    [Tags]     inv

#     ${account}       Create Dictionary
#     ...    name=Eduardo Fercanchoux
#     ...    email=edu.teste.teste.com.br
#     ...    cpf=1020304056

#     Submit signup form     ${account}
#     Notice should be        Oops! O email informado é inválido


# CPF no formato inválido
#    [Tags]     inv

#     ${account}       Create Dictionary
#     ...    name=Eduardo Fercanchoux
#     ...    email=edu.teste@teste.com.br
#     ...    cpf=102030405a

#     Submit signup form     ${account}
#     Notice should be        Oops! O CPF informado é inválido

Tentativa de pré-cadastro
    [Template]        Attempt signup
    ${EMPTY}         edu24@teste.com    99306649045    Por favor informe o seu nome completo
    Eduardo          ${EMPTY}           9306649045     Por favor, informe o seu melhor e-mail
    João Pedro       dudu@gmail.com     ${EMPTY}       Por favor, informe o seu CPF
    Geane Pacheco    edu24&teste.com    99306649045    Oops! O email informado é inválido
    Geane Pacheco    edu24teste.com    99306649045     Oops! O email informado é inválido
    Geane Pacheco    edu24&testecom    99306649045     Oops! O email informado é inválido
    Geane Pacheco    11111111111111    99306649045     Oops! O email informado é inválido
    Geane Sousa      geane@teste.com    9930664904a    Oops! O CPF informado é inválido
    Geane Sousa      geane@teste.com    77888885547    Oops! O CPF informado é inválido
    Geane Sousa      geane@teste.com    99306649088    Oops! O CPF informado é inválido

*** Keywords ***
Attempt signup
    [Arguments]    ${name}    ${email}    ${cpf}    ${output_message}

    ${account}       Create Dictionary
    ...    name=${name}
    ...    email=${email}
    ...    cpf=${cpf}

    Submit signup form     ${account}
    Notice should be        ${output_message}
