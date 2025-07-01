let fill_genericpage contents =
  let open Tyxml.Html in
  let page =
    html
    (head (title (txt "OCamlWebsite")) 
        [
          link  ~rel:[ `Stylesheet ] ~href:"./statics/home.css" ()
        ])
    (body [
      div ~a:[a_class ["header"]]
        [
          h1  [txt "Hello from TyXML!"];
          a ~a:[a_href "/"; a_class ["button"]] [txt "Home"];
          a ~a:[a_href "about"; a_class ["button"]] [txt "About"];
        ];
      div ~a:[a_class ["content_div"]]
        contents
       ])
  in
  (* Format the HTML and return a proper response *)
  Dream.html (Format.asprintf "%a" (Tyxml.Html.pp ()) page)



let empty_page_respond _request = 
  fill_genericpage @@ []


let about_page_respond _request = 
  let open Tyxml.Html in
  fill_genericpage @@  
  [
    h2 [txt "About"];
    p [txt "Diese Seite ist mein Persönliches Projekt"]
  ]