

actor Memoria {

    // Definindo variáveis de estado heap
    var heapCounter : Nat = 0;

    // Definindo variáveis de estado stable
    stable var stableCounter : Nat = 0;

    // Função para incrementar o contador da memória heap
    public func incrementHeapCounter() : async () {
        heapCounter += 1;
    };

    // Função para incrementar o contador da memória stable
    public func incrementStableCounter() : async () {
        stableCounter += 1;
    };

    // Função para obter o contador da memória heap
    public func getHeapCounter() : async Nat {
        return heapCounter;
    };

    // Função para obter o contador da memória stable
    public func getStableCounter() : async Nat {
        return stableCounter;
    };

}
