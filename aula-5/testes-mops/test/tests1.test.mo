import M "mo:motoko-matchers/Matchers";
import T "mo:motoko-matchers/Testable";
import Suite "mo:motoko-matchers/Suite";

let suite = Suite.suite("My test suite", [
    Suite.suite("Nat tests", [
        Suite.test("10 is 10", 10, M.equals(T.nat(10))),
        Suite.test("5 is greater than three", 5, M.greaterThan<Nat>(3)),
    ])
]);
Suite.run(suite);


