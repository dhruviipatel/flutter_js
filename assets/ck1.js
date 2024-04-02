// Define the checkout function
function checkout(options) {
    // Your checkout logic here
    console.log("Session Token:", options.sessionToken);
    console.log("Merchant Site ID:", options.merchantSiteId);
    console.log("Merchant ID:", options.merchantId);
    // Add other parameters handling here as needed

    // Simulating a successful checkout
    // You can replace this with your actual checkout logic
    var result = {
        status: "success",
        message: "Payment successful"
    };

    // Callback to onResult function
    if (options.onResult) {
        options.onResult(result);
    }

    // Callback to onReady function
    if (options.onReady) {
        options.onReady("Ready");
    }
}

// Define other functions or variables if needed

// You can also define the main function if you want
function main() {
    document.getElementById('checkout').innerHTML = "";
    checkout({
        sessionToken: document.getElementById('session').value,
        merchantSiteId: "<your merchantSiteId>",
        merchantId: "<your merchantId>",
        country: "US", // detect
        currency: "USD",
        userId: "259",
        renderTo: ".container_for_checkout",
        amount: "135",
        openAmount: {
            min: "1",
            max: "500"
        },
        amountSuggestions: ["110", "120", "130"],
        onResult: function(result) {
            console.log("Result", result)
        },
        billingAddress: {
            firstName: "John",
            lastName: "Smith",
            email: "john.smith@email.com",
            country: "US"
        },
        onReady: function(result) {
            console.log(result);
        },
        onSelectPaymentMethod: function(paymentDetails) {
            console.log("onSelectPaymentMethod", paymentDetails);
        },
        onPaymentEvent: function(result) {
            console.log('onPaymentEvent =>', result);
        },
        upoDeleted: function(paymentDetails) {
            console.log("upoDeleted", paymentDetails);
        },
        prePayment: function(paymentDetails) {
            return new Promise((resolve, reject) => {
                console.log(paymentDetails);
                resolve(); // reject(), reject('Message')
            });
        },
        onPaymentFormChange: function(pm, label, action, oldValue, newValue, validation, pasted) {
            console.log('onPaymentFormChange =>', pm, label, action, oldValue, newValue, validation, pasted);
        },
        disableDeclineRecovery: false,
        onDeclineRecovery: function(declineRecoveryHistory) {
            console.log('Decline Recovery History =>', declineRecoveryHistory);
            var declineRecoveryOverride;
            if (!isOverriden) {
                declineRecoveryOverride = { nextPm: true, differentCard: true, retry: true, supportMessage: "test@test.com" };
                isOverriden = true;
            }
            return new Promise((resolve, reject) => {
                resolve(declineRecoveryOverride);
            });
        },
        useDCC: "disable", // enable, force 
        strictDcc: "false", // false means customers can use a card even if it isn't "DCC Allowed"
        savePM: "true", // option to save payment method for future use and needed for apm recurring billing
        selectUpo: 83648899, // "83648899", "first"
        selectPM: "apmgw_<APM provider name>",
        disableDeleteUpoButton: false, // true
        prepopulateApmFields: {
            iban: "12345678909",
            email: "john.smith@email.com"
        },
        readonlyPrepopulateApmFields: "false", // true
        subMethod: ["PayNPlay", "QuickRegistration"], // APM providers who support the Customer Registration feature
        pmWhitelist: ["apmgw_QIWI", "apmgw_MoneyBookers"],
        showCardLogos: true, // default is false 
        blockCards: [
            ["visa", "credit", "corporate"],
            ["amex", "GB", "prepaid"]
        ], // Visa corporate credit cards and British prepaid Amex cards are blocked
        blockPasteCard: true,
        alwaysCollectCvv: "true",
        maskCvv: true,
        fullName: document.getElementById('cardHolderName').value,
        email: "john.smith@email.com",
        locale: "en", // de, es, fr, it, pt, ru
        textDirection: "ltr", // rtl
        env: "int", // "prod"
        cardLogo: {
            cardLogoPosition: "right",
            backgroundSize: "30px 40px"
        }, //or cardLogo: false -> to hide the card logo
        disableDeclineRecovery: "true",
        apmWindowType: "newTab", // popup (default), redirect
        theme: "tiles", // accordion, horizontal, cashier
        paymentTiles: "splash", // showMore
        apmConfig: {
            apmgw_PIX: {
                fields: {
                    pix_key: "hidden", // optional or hidden
                }
            },
            cardAuthMode: "3dAuthOnly", // 3dAuthForNewCardsOnly, paymentForAll (default)
            autoOpenPM: true
            // logLevel: 0,
            // i18n: {
            //     my_methods: "Meine Zahlungsmethoden"
            //     card_number: "KARTA",
            //     mm_yy: "MMM / YYY",
            //     cvv: "CVVV"
            // }
        }
    });
}
