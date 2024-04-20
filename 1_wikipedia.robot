*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${wikipedia login}    RobotTests
${wikipedia correct password}    RobotFramework
${wikipedia wrong password}    12345
${error message}    Podany login lub hasło są nieprawidłowe. Spróbuj jeszcze raz.
*** Keywords ***


*** Test Cases ***
Incorrect Log In Wikipedia
    open browser    https://pl.wikipedia.org/    chrome    #executable_path=sciezka do sterownika
    sleep    1
    click element    id:pt-login-2
    sleep    1
    input text    id:wpName1    ${wikipedia login}
    input password    id:wpPassword1    ${wikipedia wrong password}
    checkbox should not be selected    id:wpRemember
#    select checkbox    id:wpRemember
    sleep    1
    click button    id:wpLoginAttempt
    sleep    1
    ${my error message}    get text    xpath:/html/body/div[2]/div/div[3]/main/div[3]/div[3]/div[1]/div[3]/form/div[1]/div
    log to console    ${my error message}
    log    ${my error message}
    should be equal    ${error message}    ${my error message}
    capture page screenshot    my screen-{index}.png
    close browser