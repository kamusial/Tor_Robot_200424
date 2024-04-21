*** Settings ***
Documentation    If number is even - divide it by 2.
...              If number is odd - multiply by 3 and add 1.
...              Repeat algorithm until you get 1
...              3->10->5->16->8->4->2->1

*** Test Cases ***
Convergence
    ${x}   Collatz Iteration  3
    ${y}   Collatz Iteration  ${x}
    ${z}   Collatz Iteration  ${y}
    ${a}   Collatz Iteration  ${z}
    ${b}   Collatz Iteration  ${a}
    
Convergence For
    ${x}  Set Variable    3
    WHILE  ${x}!=1
       ${x}  Collatz Iteration  ${x}
    END


*** Keywords ***
Collatz Iteration
    [Arguments]    ${n}
    IF   ${n}%2 == 0
        ${result}  Evaluate    ${n}//2
    ELSE
        ${result}  Evaluate    ${n}*3+1
    END
    Log To Console    ${result}
    RETURN  ${result}
