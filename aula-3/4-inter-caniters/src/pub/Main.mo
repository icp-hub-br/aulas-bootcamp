// Publicador
import List "mo:base/List";

// Define um ator chamado Publicador
actor Publisher {

  // Cria um novo tipo chamado 'Counter' que armazena um par chave-valor de 'tópico: valor'.
  type Counter = {
    topic : Text;
    value : Nat;
  };

  // Cria um novo tipo chamado 'Subscriber' que armazena um par chave-valor de 'tópico: callback'. Callback refere-se à chamada entre canisters que envia o par chave-valor 'Counter' para canisters na variável 'subscribers'.
  type Subscriber = {
    topic : Text;
    callback : shared Counter -> ();
  };

  // Define uma variável estável que armazena a lista de canisters 'inscritos' em um tópico no canister 'Publisher'.
  stable var subscribers = List.nil<Subscriber>();

  // Define uma função que permite que canisters se inscrevam em um tópico.
  public func subscribe(subscriber : Subscriber) {
    subscribers := List.push(subscriber, subscribers);
  };

  // Define a função para criar novos tópicos enviados pelo canister 'Subscriber' dentro do par chave-valor 'Counter'.
  public func publish(counter : Counter) {
    for (subscriber in List.toArray(subscribers).vals()) {
      if (subscriber.topic == counter.topic) {
        subscriber.callback(counter);
      };
    };
  };
}