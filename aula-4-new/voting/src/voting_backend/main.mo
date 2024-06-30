import RBTree "mo:base/RBTree";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Iter "mo:base/Iter";

actor {

  var question: Text = "Qual é a sua linguagem de programação favorita?";
  var votes: RBTree.RBTree<Text, Nat> = RBTree.RBTree(Text.compare);

  public query func getQuestion() : async Text { 
    question 
  };

  // Consulta a lista de entradas e votos para cada uma
  // Exemplo: 
  //      * JSON que o frontend receberá usando os valores acima: 
  //      * [["Motoko","0"],["Python","0"],["Rust","0"],["TypeScript","0"]]

  public query func getVotes() : async [(Text, Nat)] {
      Iter.toArray(votes.entries())
  };

  // Este método recebe uma entrada para votar, atualiza os dados e retorna o hashmap atualizado
  // Exemplo de entrada: vote("Motoko")
  // Exemplo: 
  //      * JSON que o frontend receberá usando os valores acima: 
  //      * [["Motoko","1"],["Python","0"],["Rust","0"],["TypeScript","0"]]

  public func vote(entry: Text) : async [(Text, Nat)] {
    // Verifica se a entrada já tem votos.
    // Note que "votes_for_entry" é do tipo ?Nat. Isto é porque: 
    // * Se a entrada está no RBTree, o RBTree retorna um número.
    // * Se a entrada não está no RBTree, o RBTree retorna `null` para a nova entrada.
    let votes_for_entry :?Nat = votes.get(entry);
    
    // Precisamos ser explícitos sobre o que fazer quando é null ou um número para que todos os casos sejam tratados
    let current_votes_for_entry : Nat = switch votes_for_entry {
      case null 0;
      case (?Nat) Nat;
    };

    // Uma vez que temos o número de votos, atualizamos os votos para a entrada
    votes.put(entry, current_votes_for_entry + 1);

    // Retorna o número de votos como um array (para que o frontend possa exibi-lo)
    Iter.toArray(votes.entries())
  };

  public func resetVotes() : async [(Text, Nat)] {
      votes.put("Motoko", 0);
      votes.put("Rust", 0);
      votes.put("TypeScript", 0);
      votes.put("Python", 0);
      Iter.toArray(votes.entries())
  };

};