module Bindings = Bindings
module Make_bindings = Bindings.Make

exception Libusb_error

type context
(** Structure representing a [libusb] session. *)

module type S = sig
  val init_context : ?context:context -> unit -> unit
  (** Initialize [libusb].

      This function must be called before calling any other [libusb] function.
  *)

  val exit : context -> unit
  val with_init_context : ?context:context -> (unit -> 'a) -> 'a
end

module Make : (_ : Bindings.S) -> S
