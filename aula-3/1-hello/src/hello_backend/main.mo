import Debug "mo:base/Debug";


actor {
  
  
  
  let x = 1; /// declaração
  let y = x + 1; /// declaração

  let z = do {
    let x = 1;
    let y = x + 1;
    x * y + x /// expressão
  };

  public func getZ(): async Nat {
    return z;
  };
  
  //let w = 42 + (1 * 37) / 12: Nat;



  // Definindo uma variável de estado
  var state : Nat = 0;

  public func setState(newState : Nat) : async () {
      state := newState;
  };

  // Função pública para obter o estado
  public func getState() : async Nat {
      return state;
  };

  public func hello() : async Text {
    Debug.print("hello world");
    Debug.print(debug_show(("hello", 42, "world")));
    return "Hello, World!";
  };

  public query func greet(name : Text) : async Text {
    return "Hello, " # name # "!";
  };

  

  public func location(city : Text) : async Text {
      return "Hello, " # city # "!";
  };
};
