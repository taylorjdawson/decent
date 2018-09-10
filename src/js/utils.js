import entropy from 'string-entropy'

const Utils = {
  entropyIsSufficient: function (password) {
    let ent = entropy(password)
    return { entropy: ent, score: Math.floor(ent / 32) }
  },
  createPubKeyPair: function (password) {
  }
}

export default Utils
