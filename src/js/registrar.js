import contract from 'truffle-contract'
import RegistrarContract from '@contracts/SubdomainRegistrar.json'
let namehash = require('eth-ens-namehash')

const Registrar = {

  contract: null,

  instance: null,

  init: function () {
    let self = this

    return new Promise(function (resolve, reject) {
      self.contract = contract(RegistrarContract)
      self.contract.setProvider(window.web3.currentProvider)

      self.contract.deployed().then(instance => {
        self.instance = instance
        resolve()
      }).catch(err => {
        reject(err)
      })
    })
  },

  userExists: function (username) {
    let self = this
    // TODO: Must employ more nameprep here
    let normalizedUsername = namehash.normalize(username)
    let node = namehash.hash(normalizedUsername)

    return self.instance.nameExists.call(node,
      {from: window.web3.eth.accounts[0]})
  },

  register: function (user) {

  },

  deregister: function (user) {

  }
}

export default Registrar
