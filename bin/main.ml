
(* Aliased for convenience *)
module H = Tyxml.Html

let succesfull = ref 0
let failed = ref 0


let count_requests inner_handler request = 
  try%lwt 
    let%lwt response = inner_handler request in
    succesfull := !succesfull + 1;
    Lwt.return response
  with exn ->
    failed := !failed + 1;
    raise exn


let () =
  Dream.run
  @@ Dream.logger
  @@ Dream.memory_sessions
  @@ count_requests
  @@ Dream.router [
    Dream.get "/"  (fun request -> 
      match Dream.session_field request "user" with
      | None ->
        let%lwt () = Dream.invalidate_session request in
        let%lwt () = Dream.set_session_field request "user" "PhilippG" in
        OCamlWebsite.Page.fill_genericpage @@ [Tyxml.Html.txt "You weren't logged in, but now you are"]
      | Some username ->
        OCamlWebsite.Page.fill_genericpage @@ [Tyxml.Html.txt @@ Printf.sprintf "Welcome back, %s" username]
      );

    Dream.get "/about" OCamlWebsite.Page.about_page_respond;

    Dream.get "/stats" (fun _ -> Dream.html @@ Printf.sprintf "Succesfull: %i <br>Failed: %i" !succesfull !failed);

    Dream.get "/fail" (fun _ -> raise (Failure "Webapp failedSS"));
    (* load the statics *)
    Dream.get "/statics/**" (Dream.static "statics");  (* Path must match folder *)

    Dream.post "/echo" (fun request -> 
      let%lwt body = Dream.body request in
      Dream.respond ~headers:["Content-Type", "application/octet-stream"] body);
  ]
