actor {
    public query func teste1() : async Text {

        let pessoa = {
            nome = "Peter";
            sobrenome = "Paul";
        };

        let { nome; sobrenome } = pessoa;

        return "Hello " # nome # " "# sobrenome #"";
    };

    public query func teste2() : async Text {

        let pessoa = {
            nome = "Bry";
            bootcamp = true;
        };

        let { nome; bootcamp } = pessoa;

        if(bootcamp) {
            return "" # nome # " fez bootcamp!";
        } else {
            return "" # nome # " não fez bootcamp";
        };
    };
};
