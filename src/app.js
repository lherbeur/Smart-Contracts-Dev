
// Import libraries we need.
// Import our contract artifacts and turn them into usable abstractions.
import base from './base.js'
import accountsInit from './accounts.js'
import vestingImplementation from './vest.js'
document.onreadystatechange = () => {
  if (document.readyState === 'complete') {
    base()
    accountsInit()
    vestingImplementation()
  }
}
