let genericpage _request =
  let module H = Tyxml.Html in
  let page =
    H.html
      (H.head (H.title (H.txt "OCamlWebsite")) 
        [
          H.link  ~rel:[ `Stylesheet ] ~href:"./statics/home.css" ()
        ])
      (H.body [
         H.h1 [H.txt "Hello from TyXML!"];
         H.p [H.txt "This is a safe HTML page."]
       ])
  in
  (* Format the HTML and return a proper response *)
  Dream.html (Format.asprintf "%a" (Tyxml.Html.pp ()) page)
