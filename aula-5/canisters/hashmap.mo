import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Int "mo:base/Int";

actor {
    type HashMap<K, V> = HashMap.HashMap<K, V>;
    type MapTextInt = HashMap<Text, Int>;

    public query func teste1() : async Text {
        let map = HashMap.HashMap<Text, Int>(5, Text.equal, Text.hash);

        map.put("Rohit", 30);
        map.put("Kohli", 28);
        map.put("Rahul", 27);

        let rohitAge = map.get("Rohit");

        let rohitAgeText = switch (rohitAge) {
            case (?age) { Int.toText(age) };
            case null { "unknown" };
        };
            
        return rohitAgeText;
    };
}
