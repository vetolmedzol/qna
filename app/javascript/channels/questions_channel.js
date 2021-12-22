import consumer from "./consumer"

consumer.subscriptions.create("QuestionsChannel", {
    connected() {
        // Called when the subscription is ready for use on the server
        console.log("Connected to the room!");
        this.do_something();
    },

    do_something() {
        this.perform('do_something', {text: 'hello'})
        console.log('do_something')
    },

    disconnected() {
        // Called when the subscription has been terminated by the server
    },

    received(data) {
        // Called when there's incoming data on the websocket for this channel
        console.log('Received', data)
    }
});
