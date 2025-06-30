let count = ref 0

let count_requests inner_handler request = 
  count := !count + 1;
  inner_handler request;;


let () =
  Dream.run 
  @@ Dream.logger
  @@ count_requests
  @@ Dream.router [

    Dream.get "/" (fun _ -> Dream.html @@ Printf.sprintf "Request: %i" !count);

    Dream.get "/echo/:word"
      (fun request -> Dream.html (Dream.param request "word"));

  ]