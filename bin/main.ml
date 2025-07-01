
(* Aliased for convenience *)
module H = Tyxml.Html



let () =
  Dream.run
  @@ Dream.logger
  @@ Dream.router [
    Dream.get "/"  OCamlWebsite.Page.empty_page_respond;

    Dream.get "/about" OCamlWebsite.Page.about_page_respond;

    (* load the statics *)
    Dream.get "/statics/**" (Dream.static "statics");  (* Path must match folder *)
  ]
