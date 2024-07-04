import Canister "../src/tests_backend/main";
import C "mo:motoko-matchers/Canister";
import M "mo:motoko-matchers/Matchers";
import T "mo:motoko-matchers/Testable";

actor {
    let it = C.Tester({ batchSize = 8 });
    public shared func test() : async Text {

        it.should("greet me", func () : async C.TestResult = async {
          let greeting = await Canister.greet("Bob");
          M.attempt(greeting, M.equals(T.text("Hello, Bob!")))
        });

        it.shouldFailTo("greet my friend", func () : async () = async {
          let greeting = await Canister.greet("George");
          ignore greeting
        });

        await it.runAll()
        // await it.run()
    }
}