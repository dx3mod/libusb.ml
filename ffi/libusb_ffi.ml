module T = struct
  type 'a fn = 'a Ctypes.fn
  type 'a return = 'a

  let ( @-> ) = Ctypes.( @-> )
  let returning = Ctypes.returning

  type 'a result = 'a

  let dll = Dl.dlopen ~filename:"libusb-1.0.so.0" ~flags:[ RTLD_LAZY ]
  let foreign s t v = Foreign.foreign ~from:dll s t v
  let foreign_value s t = Foreign.foreign_value s t
end

include Libusb.Make_bindings (T)
