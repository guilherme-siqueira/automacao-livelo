*** Settings ***
Library           SeleniumLibrary

*** Variables ***

${TIMEOUT}    15s

${BROWSER_NAME}    Chrome
${CONTAINER}    http://${browser_container}:4444/wd/hub
${LIVELO_WEBSITE}    https://www.livelo.com.br/

${SEARCH_TEXT}    aspirador robo multilaser
${ITEM_CODE}    LVL20156634

${LIVELO_ICON}    //img[@id='img-brand']
${SEARCH_INPUT}    //input[@id='input-search']
${SEARCH_BUTTON}    //button[@id='span-searchIcon']
${SEARCH_RESULT_ITEM}    //div[contains(@id,'CC-product-list-name-${ITEM_CODE}')]
${ITEM_CODE_LABEL}    //span[@id = 'span-productId' and text()='${ITEM_CODE}']
${ADD_TO_CART_BUTTON}    //span[@id='cc-prodDetails-addToCart']
${LIVELO_SPINNER}    //div[@id='livelo-spinner']
${ITEM_VALUE}    //div[@class='tab-pane active']//div[@class='container-price-points']
${SUB_TOTAL_ITEM}    //span[@id='cc-cart-total']
${PLUS_BUTTON}    //span[starts-with(@id,'plus-ci')]
${MINUS_BUTTON}    //span[starts-with(@id,'minus-ci')]
${EMPTY_CART_MESSAGE}    //div[starts-with(@id,'custom-cart-empty')]
${CART_BUTTON}    //div[@id='div-controlCart']
${QTD_ITEM}    //span[contains(@id,'qtd-ci')]
