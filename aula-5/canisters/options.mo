actor {

    let _a : ?Nat = ?202;

    let _b : ?Text = ?"DeFi";

    let _c : ?Bool = ?true;

    func returnOption() : ?Nat {
        ?0;
    };

    func returnNull() : ?Nat {
        null;
    };

    type Result = {
        #ok;
        #err;
    };

    public query func teste1() : async Text {

        if (returnOption() == null) {
            return "Option is null";
        } else {
            return "Option is not null";
        };

        if (returnNull() == null) {
            return "Null is null";
        } else {
            return "Null is not null";
        };
    };

    public query func teste2() : async Result {
        let checker = true;

        if (checker) {
            return #ok;
        } else {
            return #err;
        };
    };
};
