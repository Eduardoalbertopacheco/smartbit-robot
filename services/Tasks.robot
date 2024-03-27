*** Settings ***
Documentation    Arquivo para testar o consumo de API com tasks

Resource    ./service.resource

*** Tasks ***
Testando a API
    Set user token
    Get account by name    Dominic Toreto