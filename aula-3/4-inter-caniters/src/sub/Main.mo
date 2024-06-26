// Subscriber

// Import the Publisher canister
import Publisher "canister:pub";

// Define an actor called 'Subscriber'
actor Subscriber {

  // Create a new type called 'Counter' that stores a key-value pair of 'topic: value'.
  type Counter = {
    topic : Text;
    value : Nat;
  };

  // Create a variable called 'count' that has a value of '0'.
  var count: Nat = 0;

  // Define a function that sends a call to the 'Publisher' canister that subscribes to a topic and triggers the 'updateCount' function.
  public func init(topic0 : Text) {
    Publisher.subscribe({
      topic = topic0;
      callback = updateCount;
    });
  };

  // Define the 'updateCount' function that updates the value associated with a topic.
  public func updateCount(counter : Counter) {
    count += counter.value;
  };

  // Define a function that queries the value of 'count'.
  public query func getCount() : async Nat {
    count;
  };
}


