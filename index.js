async function connectWallet(){
    accounts = await window.ethereum.request({method: "eth_requestAccounts"}).catch((err)=>{
        //Error handling

        console.log(err.code)
    });

    console.log(accounts)
    //console.log("Connecting to wallet...");
}