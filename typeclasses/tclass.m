% mmc tclass.m

:- module tclass.

:- interface.
:- import_module io.

:- pred main(io::di, io::uo) is det.

:- implementation.

:- import_module list.
:- import_module string.


    % The types.

:- type thing
    --->    empty_thing
    ;       thing_with_label(string).

:- type blob
    --->    empty_blob
    ;       blob_with_label(string).

    % now we can create a typeclass that has a show method,
    % we can actually call it anything we like but in solidarity
    % with the Haskell example, we will call it `show`.

:- typeclass showable(T) where [
    func show(T::in) = (string::out) is det
].

    % and now we can create the implementations... Mercury has a
    % few variations on how you can can do that but I am going to
    % keep it short and simple, all inlined code.

:- instance showable(thing) where [
    (
        show(empty_thing) = "I am an empty thing"
    ),
    (
        show(thing_with_label(L)) =
            string.format("Thing with: %s", [s(L)])
    )
].

:- instance showable(blob) where [
    (
        show(empty_blob) = "I am an empty blob"
    ),
    (
        show(blob_with_label(L)) =
            string.format("Blob with: %s", [s(L)])
    )
].


%-
%  MAIN ENTRY POINT
%-
main(!IO) :-

    Thing1 = empty_thing,
    Thing2 = thing_with_label("Geoff been in?"),

    Blob1  = empty_blob,
    Blob2  = blob_with_label("My name is Michael Caine!"),

    io.format("thing1: %s\n", [s(show(Thing1))], !IO),
    io.format("thing2: %s\n", [s(show(Thing2))], !IO),
    io.format(" blob1: %s\n", [s(show(Blob1))], !IO),
    io.format(" blob2: %s\n", [s(show(Blob2))], !IO).
