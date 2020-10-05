*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
Library           Selenium2Library
Library		  Collections

*** Variables ***
${DELAY}	0
*** Keywords ***
Generate Gender Firstname Surname
   @{maleNames}=	Create List	Aaron	Abdul	Abe	Abel	Abraham	Abram	Adalberto	Adam	Adan	Adolfo	Adolph	Adrian	Agustin	Ahmad	Ahmed	Al 
   @{femaleNames}=	Create List	Earlean	Earleen	Earlene	Earlie	Earline	Earnestine	Eartha	Easter	Eboni	Ebonie	Ebony	Echo	Eda 
   @{surNames}=	Create List	Smith	Jones	Brown	Browne	Taylor	Page	Afroudakis	Alexandris	Alexandrou	Alexiou	Alexopoulos	Anastasopoulos 

    ${randGender}=	Evaluate	random.randint(0, 1)	modules=random,sys

    ${numberSurNames}=	Get Length	${surNames}
    ${numberSurNames}=	Run Keyword	Evaluate	${numberSurNames}-1
    ${temp}=	Set Variable	random.randint(0, ${numberSurNames})
    ${index}=	Evaluate	${temp}	modules=random,sys
    ${randSurName}=	Get From List	${surNames}	${index}
    ${numberMaleNames}=	Get Length	${maleNames}
    ${numberMaleNames}=	Run Keyword	Evaluate	${numberMaleNames}-1
    ${temp}=	Set Variable	random.randint(0, ${numberMaleNames})
    ${index}=	Evaluate	${temp}	modules=random,sys
    ${randMaleName}=	Get From List	${maleNames}	${index}
    ${numberFemaleNames}=	Get Length	${femaleNames}
    ${numberFemaleNames}=	Run Keyword 	Evaluate	${numberFemaleNames}-1
    ${temp}=	Set Variable	random.randint(0, ${numberFemaleNames})
    ${index}=	Evaluate	${temp}	modules=random,sys
    ${randFemaleName}=	Get From List	${femaleNames}	${index}

    ${givenName}=	Set Variable If	${randGender}==0	${randMaleName}	${randFemaleName}
    ${gender}=	Set Variable If	${randGender}==0	Male	Female
    [Return]	${givenName}	${randSurName}	${gender}
*** Test Cases ***
Test Random
    ${x}=	Generate Gender Firstname Surname
    Log	${x}
