import Debug "mo:base/Debug";
import Blob "mo:base/Blob";
import Cycles "mo:base/ExperimentalCycles";
import Array "mo:base/Array";
import Nat8 "mo:base/Nat8";
import Text "mo:base/Text";

import Types "Types";

actor {

  // Esta função é usada para transformar a resposta recebida da nossa solicitação POST
  public query func transform(raw : Types.TransformArgs) : async Types.CanisterHttpResponsePayload {
      let transformed : Types.CanisterHttpResponsePayload = {
          status = raw.response.status;
          body = raw.response.body;
          headers = [
              {
                  name = "Content-Security-Policy";
                  value = "default-src 'self'";
              },
              { name = "Referrer-Policy"; value = "strict-origin" },
              { name = "Permissions-Policy"; value = "geolocation=(self)" },
              {
                  name = "Strict-Transport-Security";
                  value = "max-age=63072000";
              },
              { name = "X-Frame-Options"; value = "DENY" },
              { name = "X-Content-Type-Options"; value = "nosniff" },
          ];
      };
      transformed;
  };

  // Esta função envia nossa solicitação POST
  public func send_http_post_request() : async Text {

    // Primeiro, declara o canister de gerenciamento
    let ic : Types.IC = actor ("aaaaa-aa");

    // Em seguida, configure a URL e seus parâmetros de consulta. Esta parte usa uma API gratuita.
    let host : Text = "putsreq.com";
    let url = "https://putsreq.com/aL1QS5IbaQd4NTqN3a81";

    // Depois, prepare cabeçalhos para a chamada http_request do sistema. Note que as chaves de idempotência devem ser únicas, então você cria uma função que as gera.

    let idempotency_key: Text = generateUUID();
    let request_headers = [
        { name = "Host"; value = host # ":443" },
        { name = "User-Agent"; value = "http_post_sample" },
        { name= "Content-Type"; value = "application/json" },
        { name= "Idempotency-Key"; value = idempotency_key }
    ];

    // Como o corpo da solicitação é um array de [Nat8], a seguir você faz o seguinte:
    // 1. Escreve uma string JSON
    // 2. Converte o ?Text opcional em um Blob, que é uma representação intermediária antes de você convertê-lo em um array de [Nat8]
    // 3. Converte o Blob em um array [Nat8]

    let request_body_json: Text = "{ \"name\" : \"Grogu\", \"force_sensitive\" : \"true\" }";
    let request_body_as_Blob: Blob = Text.encodeUtf8(request_body_json);
    let request_body_as_nat8: [Nat8] = Blob.toArray(request_body_as_Blob); // por exemplo [34, 34,12, 0]

    // Então você transforma o conteúdo
    let transform_context : Types.TransformContext = {
      function = transform;
      context = Blob.fromArray([]);
    };

    // Em seguida, você faz a solicitação POST
    let http_request : Types.HttpRequestArgs = {
        url = url;
        max_response_bytes = null; // opcional para solicitação
        headers = request_headers;
        // observe: o tipo de `body` é ?[Nat8], então você passa aqui como "?request_body_as_nat8" em vez de "request_body_as_nat8"
        body = ?request_body_as_nat8;
        method = #post;
        transform = ?transform_context;
    };

    // Agora, você precisa adicionar alguns ciclos à sua chamada, pois ciclos para pagar pela chamada devem ser transferidos com a chamada.
    // A forma como Cycles.add() funciona é que ele adiciona esses ciclos à próxima chamada assíncrona
    // "A função add(amount) indica a quantidade adicional de ciclos a serem transferidos na próxima chamada remota"
    // Veja: https://internetcomputer.org/docs/current/references/ic-interface-spec/#ic-http_request

    Cycles.add(21_850_258_000);

    // Agora que você tem a solicitação HTTP e ciclos para enviar com a chamada, você pode fazer a solicitação HTTP e aguardar a resposta.

    let http_response : Types.HttpResponsePayload = await ic.http_request(http_request);

    // Uma vez que você tenha a resposta, você precisa decodificá-la. O corpo da resposta HTTP deve voltar como [Nat8], que precisa ser decodificado para texto legível.
    // Para fazer isso, você:
    //  1. Converte o [Nat8] em um Blob
    //  2. Usa o método Blob.decodeUtf8() para converter o Blob em um ?Text opcional
    //  3. Usa a sintaxe "Let... else" do Motoko para desembrulhar o que é retornado de Text.decodeUtf8()

    let response_body: Blob = Blob.fromArray(http_response.body);
    let decoded_text: Text = switch (Text.decodeUtf8(response_body)) {
        case (null) { "No value returned" };
        case (?y) { y };
    };

    // Finalmente, você pode retornar a resposta do corpo.
    let result: Text = decoded_text # ". See more info of the request sent at at: " # url # "/inspect";
    result
  };

  // Como passo final, você define uma função auxiliar privada que gera um identificador universalmente único. Neste exercício, ele retorna uma constante, mas na prática deve retornar um identificador único.
  func generateUUID() : Text {
    "UUID-123456789";
  }
};
