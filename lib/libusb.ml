module Bindings = Bindings
module Make_bindings = Bindings.Make

exception Libusb_error

type context = Bindings.Context.t Ctypes.abstract Ctypes.ptr

module type S = sig
  val init_context : ?context:context -> unit -> unit
  val exit : context -> unit
  val with_init_context : ?context:context -> (unit -> 'a) -> 'a
end

module Make (B : Bindings.S) = struct
  let init_context ?(context = Bindings.Context.make ()) () =
    if B.init_context (Bindings.(ref_of Context.t) context) Ctypes.null 0 <> 0
    then raise Libusb_error

  let exit context = B.exit context

  let with_init_context ?(context = Bindings.Context.make ()) f =
    init_context ~context ();
    Fun.protect f ~finally:(fun () -> exit context)
end
