import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";

actor {
    let a : [Nat] = [1, 2, 3];
    let iter = Array.vals(a);

    assert(?1 == iter.next());
    assert(?2 == iter.next());
    assert(?3 == iter.next());
    assert(null == iter.next());

    public query func teste1() : async Text {
        var counter = 0;

        for (i in Iter.range(0,4)) {
            counter += i;
        };

        return "counter: " # Nat.toText(counter);
    };

    public query func teste2() : async Text {
        var counter = 0;

        for (i in Iter.range(0,4)) {
            counter += i;
        };

        return "counter: " # Nat.toText(counter);
    };


    public query func teste3() : async ?Nat {

        let myRange : Iter.Iter<Nat> = Iter.range(1, 3);

        let _num1 = myRange.next(); // returns 1
        let _num2 = myRange.next(); // returns 2
        let num3 = myRange.next(); // returns 3

        return num3;
    };

    public query func teste4() : async ?Nat {

        let myRange : Iter.Iter<Nat> = Iter.range(1, 3);

        let _num1 = myRange.next(); // returns 1
        let _num2 = myRange.next(); // returns 2
        let _num3 = myRange.next(); // returns 3
        let num4 = myRange.next(); // returns null

        return num4;
    };

    public query func teste5() : async Nat {

        let myRange : Iter.Iter<Nat> = Iter.range(1, 3);

        var sum = 0;

        func update(a : Nat, _b: Nat) {
            sum += a;
        };

        Iter.iterate<Nat>(myRange, update);

        return sum;
    };

    public query func teste6() : async Nat {

        let myRange : Iter.Iter<Nat> = Iter.range(1, 3);

        return Iter.size(myRange);
    };
}
