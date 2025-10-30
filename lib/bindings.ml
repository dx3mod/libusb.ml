open Ctypes

let ref_of t v = allocate (ptr t) v

(** Structure representing a libusb session.

    The concept of individual libusb sessions allows for your program to use two
    libraries (or dynamically load two modules) which both independently use
    libusb. This will prevent interference between the individual libusb users -
    for example libusb_set_option() will not affect the other user of the
    library, and libusb_exit() will not destroy resources that the other user is
    still using.

    Sessions are created by libusb_init_context() and destroyed through
    libusb_exit(). If your application is guaranteed to only ever include a
    single libusb user (i.e. you), you do not have to worry about contexts: pass
    NULL in every function call where a context is required, and the default
    context will be used. Note that libusb_set_option(NULL, ...) is special, and
    adds an option to a list of default options for new contexts. *)
module Context = struct
  type t

  let t : t abstract typ = abstract ~name:"libusb_context" ~size:0 ~alignment:0
  let make () = allocate t (make t)
  let default = coerce (ptr void) (ptr @@ ptr t) null
end

module type S = sig
  type 'a result
  and 'a return

  val init_context :
    Context.t abstract Ctypes_static.ptr Ctypes_static.ptr ->
    unit Ctypes_static.ptr ->
    int ->
    int
  (** Initialize libusb.

      This function must be called before calling any other libusb function.

      If you do not provide an output location for a context pointer, a default
      context will be created. If there was already a default context, it will
      be reused (and nothing will be initialized/reinitialized and options will
      be ignored). If num_options is 0 then options is ignored and may be NULL.
  *)

  val exit : Context.t abstract ptr -> unit
  (** Deinitialize libusb.

      Should be called after closing all open devices and before your
      application terminates. *)
end

module Make (F : FOREIGN) = struct
  type 'a result = 'a F.result
  and 'a return = 'a F.return

  open F

  let init_context =
    foreign "libusb_init_context"
    @@ ptr (ptr Context.t)
    @-> ptr void @-> int @-> returning int

  let exit = foreign "libusb_exit" @@ ptr Context.t @-> returning void
end
