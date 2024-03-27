*** Settings ***
Documentation        Suite de testes de adesão de planos

Resource        ../resources/Base.resource

Test Setup       Start session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve poder realizar um nova adesão
    [Tags]    new
    ${data}    Get json fixture    memberships    create

    Delete Account By Email    ${data}[account][email]
    Insert Account             ${data}[account]

    SingIn admin
    Go to memberships
    Create new membership    ${data}
    # Sleep    2
    # ${html}        Get Page Source
    # Log        ${html}
    Toast should be        Matrícula cadastrada com sucesso.
    Sleep    2

Não deve realizar adesão duplicada
    [Tags]    dup

    ${data}    Get json fixture    memberships    create
    
    # Delete Account By Email    ${data}[account][email]
    # Insert Account             ${data}[account]

    Insert Membership          ${data}

    SingIn admin
    Go to memberships
    # Create new membership      ${data}
    # Sleep    8
    Create new membership      ${data}
    Toast should be        O usuário já possui matrícula.

Deve buscar por nome
    [Tags]    search

    ${data}       Get json fixture    memberships    search

    Insert Membership    ${data}
    SingIn admin
    Go to memberships
    Search by name           ${data}[account][name]
    Should filter by name    ${data}[account][name]

Deve excluir uma matrícula
    [Tags]  remove

    ${data}       Get json fixture    memberships    remove

    Insert Membership    ${data}
    SingIn admin
    Go to memberships
    Request removal    ${data}[account][name]
    Confirm removal
    Membership should be not visible    ${data}[account][name]
