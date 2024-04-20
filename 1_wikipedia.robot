*** Settings ***
Library    SeleniumLibrary

*** Variables ***


*** Keywords ***


*** Test Cases ***
Test 1
    open browser    https://pl.wikipedia.org/    chrome    #executable_path=sciezka do sterownika
    sleep    3
    click element    id:pt-login-2
    sleep    3
    input text    id:wpName1    Kamil
    input text    id:wpPassword1    haslo
    sleep    3
    close browser