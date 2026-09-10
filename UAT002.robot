*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${CHROME_BROWSER_PATH}    ${EXECDIR}${/}ChromeForTesting${/}chrome-win64${/}chrome.exe
${CHROME_DRIVER_PATH}     ${EXECDIR}${/}ChromeForTesting${/}chromedriver-win64${/}chromedriver.exe
${URL}                    http://sampleapp.tricentis.com/

*** Keywords ***


*** Test Cases ***
Open Insurance Main Page
    ${chrome_options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    ${chrome_options.binary_location}    Set Variable    ${CHROME_BROWSER_PATH}

    ${service}    Evaluate    sys.modules["selenium.webdriver.chrome.service"].Service(executable_path=r"${CHROME_DRIVER_PATH}")    sys

    Create Webdriver    Chrome    options=${chrome_options}    service=${service}
    Maximize Browser Window
    Go To    ${URL}
    Title Should Be    Tricentis Vehicle Insurance

Enter InvalidVehicle Data for Automobile
    Click Element    id=nav_automobile
    Wait Until Page Contains    Enter Vehicle Data    15s

    Select From List By Label    id=make    BMW
    Input Text    id=engineperformance    3000
    Input Text    id=dateofmanufacture    09/09/2020
    Select From List By Label    id=numberofseats    5
    Select From List By Label    id=fuel    Electric Power
    Input Text    id=listprice    30000
    Input Text    id=licenseplatenumber    CKK1234
    Input Text    id=annualmileage    10000

    

    Wait Until Page Contains    Must be a number between 1 and 2000    15s


Enter Incomplete Insurance Data
    Clear Element Text    id=engineperformance
    Input Text    id=engineperformance    110
    Click Button    id=nextenterinsurantdata

    Wait Until Page Contains    Enter Insurant Data    15s
    Location Should Contain    app.php
    
    
    Input Text    id=lastname    Sandee
    Input Text    id=birthdate    01/31/1990

    Click Element    xpath=//label[.//input[@id="gendermale"]]

    Input Text    id=streetaddress    KKU
    Select From List By Label    id=country    Thailand
    Input Text    id=zipcode    40002
    Input Text    id=city    Khon Kaen
    Select From List By Label    id=occupation    Employee

    Click Element    xpath=//label[.//input[@id="other"]]
    
    Wait Until Page Contains    This field is mandatory    15s
    #Click Button    id=nextenterproductdata

Enter Incomplete Product Data

    Input Text    id=firstname    Wichai
    Click Button    id=nextenterproductdata
    Wait Until Page Contains    Enter Product Data    15s

    #Input Text    id=startdate    10/15/2026
    Select From List By Value    id=insurancesum    7000000
    Select From List By Label    id=meritrating    Bonus 1
    Select From List By Label    id=damageinsurance    No Coverage

    Click Element    xpath=//label[.//input[@id="EuroProtection"]]
    Checkbox Should Be Selected    id=EuroProtection

    Select From List By Label    id=courtesycar    Yes
    
    Wait Until Page Contains    This field is mandatory    15s