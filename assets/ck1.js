const initCheckout = () => {
    const onResult = function (result) {
        // console.log(result)
        console.log('Final callback data received by caller', JSON.stringify(result))
    }

    /*
       CHECKOUT INITIALIZARION 
       ---------------------------------------
    */
    checkout({
        env: 'test', //prod for production
        renderTo: '.container_for_checkout', //your placeholder for the checkout component
        //credentials
        sessionToken: "6a70c00a-390e-4389-ab23-9922407f6018",
        merchantSiteId: "246018",
        merchantId: "2950421966619096832",
        //amount and currency for presentation purposes
        currency: 'CAD',
        amount: 135,
        //basic settings
        country: 'CA',
        locale: 'en',
        fullName: 'dhruvi', //simulates 3DS challenge, FL-BRW1 will simulate frictionless
        email: 'integration@nuvei.com',

        onResult: onResult, //with this callback you will recieve the transaction outcome and can react to it

        // optional UI settings
        payButton: "amountButton",
        showResponseMessage: true,
        //autoOpenPM: true,
        alwaysCollectCvv: false,


        fieldStyle: {
            "base": {
                "iconColor": "#c4f0ff",
                "color": "#6b778c",
                "fontWeight": 400,
                "fontFamily": "Nunito Sans",
                "fontSize": "18px",
                "fontSmoothing": "antialiased",
                ":-webkit-autofill": {
                    "color": "#ffffff"
                },
                "::placeholder": {
                    "color": "#6b778c" // default one picked from chrome
                }
            },
            "invalid": {
                "iconColor": "#FFC7EE",
                "color": "#FFC7EE"
            }
        }
    })
}
