import { Controller } from "stimulus"
import consumer from '../channels/consumer'

export default class extends Controller {
  static targets = ['container']
  static values = {
    chatroomId: Number
  }

  connect() {
    this.channel = consumer.subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      { received: data => {
        this.containerTarget.insertAdjacentHTML('beforeend', data)
        this.containerTarget.scrollTo(0, this.containerTarget.scrollHeight)
      }}
    )
  }

  disconnect() {
    this.channel.unsubscribe()
  }

  resetForm(event) {
    event.target.reset()
  }
}
