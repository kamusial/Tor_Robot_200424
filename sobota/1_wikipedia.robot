*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${wikipedia login}    RobotTests
${wikipedia correct password}    RobotFramework
${wikipedia wrong password}    12345
${error message}    Podany login lub hasło są nieprawidłowe. Spróbuj jeszcze raz.

*** Keywords ***
Login Wikipedia
    [Arguments]    ${login}    ${password}
    open browser    https://pl.wikipedia.org/    chrome    #executable_path=sciezka do sterownika
    maximize browser window
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

*** Test Cases ***
Correct log in Wikipedia
    Login Wikipedia    ${wikipedia login}    ${wikipedia correct password}
    element should be visible    //*[@id="n-mainpage-description"]/a/span

Incorrect Log In Wikipedia
    Login Wikipedia    ${wikipedia login}    ${wikipedia wrong password}
    ${my error message}    get text    xpath:/html/body/div[2]/div/div[3]/main/div[3]/div[3]/div[1]/div[3]/form/div[1]/div
    log to console    Przechwycona wiadomosc: ${my error message}, sprawdzam z: ${error message}
    log    Przechwycona wiadomosc: ${my error message}, sprawdzam z: ${error message}
    should be equal    ${error message}    ${my error message}
    capture page screenshot    ../screens/my screen-{index}.png
    close browser