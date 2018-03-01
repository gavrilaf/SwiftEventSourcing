This sample demonstrates Events Sourcing pattern design principles. You can meet with classical Events Sourcing description in Martin Fowler paper https://martinfowler.com/eaaDev/EventSourcing.html

The main idea of Event Sourcing - we do not change state of our system directly. Instead, we create set of objects “events” that change system state.
Events are stored into special storage “Events storage”. All events have timestamps, so events are processed and stored consistently. 

It means, we are able to restore system state for every point of time. Just “play events” from initial state to the point that we needed. Other advantage it’s a thread safe. Remember, all events are processed and stored consistently.

For example, imagine a bank account. You can deposit, you can withdrawal money, or block it etc. All these events can happen simultaneously but nevertheless your account must be in consistent state. It’s your money, you must be sure, that it’s safe. More over it's very important have the ability to rollback some operations or to restore account state for defined point of time.
It’s hard to implement using classical methods but very easy with Event Sourcing.

So, our sample has following components:

* **Manager** - it’s a "bank service”. It receives command and routes it to appropriate account.
* **Command** - which request that something should happened
* **Account (aggregator)** - handles Command and generates Event. Also can restore its state based on Events sequence.
* **Event store** - stores all events that have happened
