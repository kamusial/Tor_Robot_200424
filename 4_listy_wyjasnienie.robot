

*** Variables ***
@{my list}    Kamil  piesek  kotek  papuga  robot  framework  monitor
@{second list}    Kamil    INFO    False   False


*** Test Cases ***
my test
    log    ${my list}
    log    @{second list}
