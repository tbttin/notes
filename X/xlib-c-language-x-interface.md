# Chapter 1. Introduction to Xlib

- Why buffering (it's so basic, SHAME):

  + Synchronize data transfer by temporary store it till it ready to
    transfer.

  + Reduce I/O calls

  + E.g. input multi digit number in a console.

- Standard header files:

  + `<X11/Xlib.h>` includes `<X11/X.h>`

  + `<X11/Xlib.h>` must include before `<X11/Xcms.h>`,  `<X11/Xutil.h>`,
    `<X11/resource.h>`

  + `<X11/keysym.h>` includes `<X11/keysymdef.h>`

  + `<X11/Xlibint.h>` includes `<X11/Xlib.h>` `<X11/Xproto.h>`

  + `<X11/Xproto.h>` includes `<X11/Xprotostr.h>`

- [Naming and Argument
  Conventions](https://x.z-yx.cc/libX11/libX11/02-chapter-1-introduction-to-xlib.html#Naming_and_Argument_Conventions_within_Xlib)

  Later is Porgraming Considerations.

# Chapter 2. Display functions

