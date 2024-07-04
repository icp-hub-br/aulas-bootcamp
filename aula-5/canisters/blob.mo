import Blob "mo:base/Blob";

actor {
    let blob1 : Blob = "\00\ef\00" : Blob;
    let blob2 : Blob = "\00\ff\00" : Blob;

    public query func teste1() : async Text {

        if(Blob.lessOrEqual(blob1, blob2)) {
            return "blob1 é menor ou igual!";
        } else {
            return "blob2 é menor ou igual!";
        };
    };

    let a : [Nat8] = [253, 254, 255];

    let blob3 : Blob = Blob.fromArray(a);

    public query func teste2() : async Text {

        if(Blob.equal(blob1, blob3)) {
            return "blobs iguais!";
        } else {
            return "blob diferentes!";
        };
    };
}