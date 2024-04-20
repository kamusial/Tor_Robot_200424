*** Settings ***
Library    SeleniumLibrary
test setup     start test
test teardown    finish test

*** Variables ***
${wikipedia login}    RobotTests
${wikipedia correct password}    RobotFramework
${wikipedia wrong password}    12345
${error message}    Podany login lub hasło są nieprawidłowe. Spróbuj jeszcze raz.

*** Keywords ***
start test
    open browser    https://pl.wikipedia.org/    chrome    #executable_path=sciezka do sterownika
    maximize browser window

finish test
    capture page screenshot    C:\\Users\\vdi-student\\Desktop\\Tor_Robot_200424\\screens\\myscreen-{index}.png
    close browser

Login Wikipedia
    [Arguments]    ${login}    ${password}
    sleep    1
    click element    id:pt-login-2
    sleep    1
    input text    id:wpName1    ${login}
    input password    id:wpPassword1    ${password}
    checkbox should not be selected    id:wpRemember
#    select checkbox    id:wpRemember
    sleep    1
    click button    id:wpLoginAttempt
    sleep    1

Search in Wikipedia
    [Arguments]    ${text}
    input text    name:search    ${text}
#    click button    xpath:/html/body/div[1]/header/div[2]/div/div/div/form/div/button
    press keys    name:search    RETURN

*** Test Cases ***
Correct log in Wikipedia
    Login Wikipedia    ${wikipedia login}    ${wikipedia correct password}
    element should be visible    //*[@id="n-mainpage-description"]/a/span
    Search in Wikipedia    dokad noca tutpa jez

Incorrect Log In Wikipedia
    Login Wikipedia    ${wikipedia login}    ${wikipedia wrong password}
    ${my error message}    get text    xpath:/html/body/div[2]/div/div[3]/main/div[3]/div[3]/div[1]/div[3]/form/div[1]/div
    log to console    Przechwycona wiadomosc: ${my error message}, sprawdzam z: ${error message}
    log    Przechwycona wiadomosc: ${my error message}, sprawdzam z: ${error message}
    should be equal    ${error message}    ${my error message}

Search
    Search in Wikipedia    costam
