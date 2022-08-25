import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="card"
export default class extends Controller {
  static values = {
    stripeKey: String,
    id: Number,
    stripeId: String,
    stripeAccount: String,
  }
  static targets = ['number', 'expiry', 'cvc']

  async connect() {
    // Initialize Stripe
    console.log(this.stripeKeyValue)
    this.stripe = Stripe(this.stripeKeyValue, {
      stripeAccount: this.stripeAccountValue,
      betas: ['issuing_elements_2'],
    })
    this.elements = this.stripe.elements()

    // Fetch an ephemeral key from the server
    const nonce = await this.createNonce()
    console.log({nonce})
    const ephemeralKey = await this.fetchEphemeralKey(nonce)
    console.log({ephemeralKey})

    // Re retrieve the issued card
    const cardResult = await this.fetchCard(ephemeralKey, nonce);

    // Mount the issuing elements
    this.mountElements()
  }

  mountElements() {
    const params = {
      issuingCard: this.stripeIdValue,
      style: {
        base: {
          color: 'white'
        }
      }
    }
    const number = this.elements.create('issuingCardNumberDisplay', params)
    number.mount(this.numberTarget)

    const expiry = this.elements.create('issuingCardExpiryDisplay', params)
    expiry.mount(this.expiryTarget)

    const cvc = this.elements.create('issuingCardCvcDisplay', params)
    cvc.mount(this.cvcTarget)
  }

  async createNonce() {
    const {nonce} = await this.stripe.createEphemeralKeyNonce({
      issuingCard: this.stripeIdValue
    })
    return nonce
  }

  async fetchEphemeralKey(nonce) {
    return await fetch(`/cards/${this.idValue}/ephemeral_key?nonce=${nonce}&version=2022-08-01`).then(r => r.json())
  }

  async fetchCard(ephemeralKey, nonce) {
    return await this.stripe.retrieveIssuingCard(this.stripeIdValue, {
      ephemeralKeySecret: ephemeralKey.secret,
      nonce: nonce,
    })
  }
}
