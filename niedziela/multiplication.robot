*** Test Cases ***
Multiplication
    ${my_numbers}   Create List    23  12  6  1  3
    ${result}  Multiply    ${my_numbers}
    Log To Console    ${result}


*** Keywords ***
Multiply
    [Arguments]    ${numbers}
    ${result}  Set Variable    1
    VAR   ${result}  1
    FOR   ${i}  IN  @{numbers}
        ${result}  Evaluate    ${result}*${i}
    END
    RETURN   ${result}
