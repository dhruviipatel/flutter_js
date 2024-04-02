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
                declineRecoveryOverride = {nextPm: true, differentCard: true, retry: true, supportMessage: "test@test.com"}; 
                isOverriden = true; 
            } 
            return new Promise((resolve, reject) => { 
                resolve(declineRecoveryOverride); 
            }); 
        }, 
    });