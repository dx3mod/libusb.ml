(lang dune 3.20)

(name libusb)

(generate_opam_files true)

(source
 (github dx3mod/libusb.ml))

(authors "Mikhail Lopatin <dx3mod@bk.ru>")

(maintainers "Mikhail Lopatin <dx3mod@bk.ru>")

(license MIT)

; (documentation https://url/to/documentation)

(package
 (name libusb)
 (synopsis "Libusb library bindings")
 (description "Libusb library bindings")
 (depends ocaml (odoc :with-docs))
 (tags (usb)))
