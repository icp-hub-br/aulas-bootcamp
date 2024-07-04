import RBTree "mo:base/RBTree";
import Text "mo:base/Text";
import Iter "mo:base/Iter";


actor {
    let textIntTree = RBTree.RBTree<Text, Int>(Text.compare);
    textIntTree.put("bitcoin", 1);
    textIntTree.put("ETH", 2);

    public query func teste1() : async ?Int {            
        return textIntTree.get("bitcoin");
    };

    let textIntTree2 = RBTree.RBTree<Text, Int>(Text.compare);
    textIntTree2.put("bitcoin", 1);
    textIntTree2.put("ETH", 2);
    textIntTree2.put("ICP", 3);

    let entries : Iter.Iter<(Text, Int)> = textIntTree2.entries();

    let _array : [(Text, Int)] = Iter.toArray(entries)
}
