
(* Aliased for convenience *)
module H = Tyxml.Html



let () =
  Dream.run
  @@ Dream.logger
  @@ Dream.router [
    Dream.get "/" OCamlWebsite.Page.genericpage;

    (* load the statics *)
    Dream.get "/statics/**" (Dream.static "statics");  (* Path must match folder *)
  ]
