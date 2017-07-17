
const accountsInit = () => {
  window.web3.eth.getAccounts((err, accs) => {
    if (err != null) {
      window.alert(`There was an error fetching your accounts.`)
      return
    }
    if (accs.length === 0) {
      window.alert(`Couldn't get any accounts! Make sure your Ethereum client is configured correctly.`)
      return
    }
    Object.defineProperty(window.App, 'accounts', {
      value: accs,
      configurable: false,
      writable: false
    })
    console.log(window.App.accounts)
  })
}

export default accountsInit
