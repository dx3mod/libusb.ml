# libusb.ml

> [!IMPORTANT]  
> It is currently at an early stage of development...

A yet modern [libusb] library bindings for [OCaml] powered by [Ctypes] library.

## Building (developer version)

Requirements: OCaml >= 4.14, Dune build-system, OPAM package manager (optional), Odoc documentation generator (optional).

```console
$ git clone https://github.com/dx3mod/libusb.ml.git
$ opam install . --deps-only
$ dune build
```

## Overview

```ocaml
#require "libusb";;
#require "libusb-ffi";;

module Usb = Libusb.Make (Libusb_ffi)

Usb.with_init_context @@ fun () ->
  (* ... *)
```

## References

- [libusb] official site
- Related old [ocaml-usb](https://github.com/letoh/ocaml-usb) project. Now it's die.

[libusb]: https://libusb.info
[OCaml]: https://ocaml.org
[Ctypes]: https://github.com/yallop/ocaml-ctypes