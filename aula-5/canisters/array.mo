import Array "mo:base/Array";
import Text "mo:base/Text";
import Nat "mo:base/Nat";

actor {
    let ages : [Nat] = [1, 2, 5, 6, 9, 7];

    func isEven(x : Nat) : Bool {
        x % 2 == 0
    };

    let evenAges : [Nat] = Array.filter<Nat>(ages, isEven);

    public query func teste1() : async Text {
        let firstEvenAge : ?Nat = Array.find<Nat>(evenAges, isEven);

        return switch (firstEvenAge) {
            case (?age) {
                "First even age: " # Nat.toText(age);
            };
            case null {
                "No even age";
            };
        };
    };

    let ages2 = [18, 25, 31, 37, 42, 55, 62];

    func isGreaterThan40(ages : Nat) : Bool {
        ages > 40;
    };

    let firstAgeGreaterThan40 : ?Nat = Array.find<Nat>(ages2, isGreaterThan40);

    public query func teste2() : async Text {
        switch (firstAgeGreaterThan40) {
            case (?age) {
                return "First age greater than 40: " # Nat.toText(age);
            };
            case null {
                return "No age greater than 40";
            };
        };
    };
}
