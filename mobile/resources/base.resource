*** Settings ***
Documentation        Arquivo principal do projeto de testes automatizados para mobile

Library              AppiumLibrary
Library             JSONLibrary
Library            ../../libs/Database.py

Resource        ../../services/service.resource
Resource        ./actions/login.resource
Resource        ./actions/account.resource
Resource        ./actions/mybody.resource
Resource        ./actions/components/menu.resource
Resource        ./actions/components/popup.resource

*** Keywords ***

Start session
    Open Application    http://localhost:4723
    ...                 platformName=Android
    ...                 automationName=UIAutomator2
    ...                deviceName=Emulator
    ...                udid=emulator-5554
    ...                app=${EXECDIR}/app/smartbit-beta.apk
    ...                autoGrantPermission=true
    Wait Until Page Contains    IP da API    30

Finish session
    Capture Page Screenshot
    Close Application

Get json fixture
    [Arguments]       ${scenario}
    ${data}    Load Json From File
    ...    ${EXECDIR}/resources/fixtures/data.json
    ...    encoding=utf-8
    
    [Return]    ${data}[${scenario}]