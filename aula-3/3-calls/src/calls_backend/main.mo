import Text "mo:base/Text";

actor {

  
  public query func say(phrase : Text) : async Text {
    return phrase;
  };

  public func test(text : Text) : async Bool {
        let size = Text.size(text);
        return size % 2 == 0;
    };
};
