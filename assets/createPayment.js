sfc.createPayment({
    sessionToken: result.sessionToken, // received from openOrder API
    openAmount: "200",
    paymentOption: {
        card: {
            cardNumber: "5111426646345761",
            cardHolderName: "John Smith",
            expirationMonth: "12",
            expirationYear: "2030",
            CVV: "217"
        },
            subMethod: {
                subMethod: "Skrill1Tap"
            }
    },
    billingAddress: {
        firstName: "John",
        lastName: "Smith",
        email: "john.smith@email.com",
        country: "US"
    },
    cardLogo: {
        cardLogoPosition: "right",
            backgroundSize: "30px 40px"
        },  //or "cardLogo": "false" -> to hide the card logo
    apmWindowType: "newTab", // popup (default), redirect, customRedirect
    alwaysCollectCvv: "optional",
}, function(res) {
    console.log(res)
    if (res.cancelled === true) {
        example.querySelector('.token').innerText = 'cancelled';
    } else {
        example.querySelector('.token').innerText = res.transactionStatus +
            ' - Reference: ' + res.transactionId;
    }
    example.classList.add('submitted');
});