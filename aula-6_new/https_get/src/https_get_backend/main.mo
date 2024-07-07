// import Debug "mo:base/Debug";
import Blob "mo:base/Blob";
import Cycles "mo:base/ExperimentalCycles";
// import Error "mo:base/Error";
// import Array "mo:base/Array";
// import Nat8 "mo:base/Nat8";
import Nat64 "mo:base/Nat64";
import Text "mo:base/Text";

import Types "Types";

actor {

    // Cria uma função que transforma o conteúdo bruto em um payload HTTP.
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

  // Esta função envia nossa solicitação GET

  public func get_icp_usd_exchange() : async Text {

    // Primeiro, declara o canister de gerenciamento
    let ic : Types.IC = actor ("aaaaa-aa");

    // Em seguida, você precisa definir os argumentos para nossa solicitação GET

    // Comece com a URL e seus parâmetros de consulta

    let ONE_MINUTE : Nat64 = 60;
    let start_timestamp : Types.Timestamp = 1682978460; // 1º de maio de 2023 22:01:00 GMT
    let end_timestamp : Types.Timestamp = 1682978520; // 1º de maio de 2023 22:02:00 GMT
    let host : Text = "api.pro.coinbase.com";
    let url = "https://" # host # "/products/ICP-USD/candles?start=" # Nat64.toText(start_timestamp) # "&end=" # Nat64.toText(end_timestamp) # "&granularity=" # Nat64.toText(ONE_MINUTE);

    // Prepara cabeçalhos para a chamada http_request do sistema.

    let request_headers = [
        { name = "Host"; value = host # ":443" },
        { name = "User-Agent"; value = "exchange_rate_canister" },
    ];

    // Em seguida, você define uma função para transformar o contexto da solicitação de um tipo de dado blob para um array.

    let transform_context : Types.TransformContext = {
      function = transform;
      context = Blob.fromArray([]);
    };

    // Finalmente, define a solicitação HTTP.

    let http_request : Types.HttpRequestArgs = {
        url = url;
        max_response_bytes = null; // opcional para solicitação
        headers = request_headers;
        body = null; // opcional para solicitação
        method = #get;
        transform = ?transform_context;
    };

    // Agora, você precisa adicionar alguns ciclos à sua chamada, pois ciclos para pagar pela chamada devem ser transferidos com a chamada.
    // A forma como Cycles.add() funciona é que ele adiciona esses ciclos à próxima chamada assíncrona.
    // "Função add(amount) indica a quantidade adicional de ciclos a serem transferidos na próxima chamada remota".
    // Veja: https://internetcomputer.org/docs/current/references/ic-interface-spec/#ic-http_request

    Cycles.add(20_949_972_000);

    // Agora que você tem a solicitação HTTP e ciclos para enviar com a chamada, você pode fazer a solicitação HTTP e aguardar a resposta.

    let http_response : Types.HttpResponsePayload = await ic.http_request(http_request);

    // Uma vez que você tenha a resposta, você precisa decodificá-la. O corpo da resposta HTTP deve voltar como [Nat8], que precisa ser decodificado para texto legível.
    // Para fazer isso, você:
    //  1. Converte o [Nat8] em um Blob
    //  2. Usa o método Blob.decodeUtf8() para converter o Blob em um ?Text opcional
    //  3. Usa um switch para chamar explicitamente ambos os casos de decodificação do Blob em ?Text

    let response_body: Blob = Blob.fromArray(http_response.body);
    let decoded_text: Text = switch (Text.decodeUtf8(response_body)) {
        case (null) { "No value returned" };
        case (?y) { y };
    };

    // Finalmente, você pode retornar a resposta do corpo.

    // A resposta da API será assim:

    // ("[[1682978460,5.714,5.718,5.714,5.714,243.5678]]")

    // O que pode ser formatado assim
    //  [
    //     [
    //         1682978460, <-- início/timestamp
    //         5.714, <-- baixo
    //         5.718, <-- alto
    //         5.714, <-- abertura
    //         5.714, <-- fechamento
    //         243.5678 <-- volume
    //     ],
    // ]

    decoded_text
  };

};
