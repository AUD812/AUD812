// Playing with text (strings).
/*
Text is stored in strings.
*/

://:Store a text
(
a = ".()+@&* asdf asdf asdf asdf 123 123 123";
)
//:a is now a String
(
a.class;
)
//:find the superclass of string (the kind of thing that String is):
(
a.class.superclass;
)
//:find the superclass of that
(
a.class.superclass.superclass;
)
//:So, a String is an ArrayedCollection.
(
// You can access any element in an ArrayedCollection (i.e. a String also), via index.
)
//:Get the 3d element of the string:
(
a[2]; // 2 because we start counting at 0
)
//:the same thing can be written like this:
(
a.at(2);
)
//:or like this:
(
a at: 2;
)
//:An element of a string array is a character:
(
a[2].class; // Char
)
//:You can get a number from a Char by sending it the message 'ascii'.
(
a[2].ascii; // ')' translates to the number 41
)
//:Now collect all asciis into an array:
(
b = a.ascii;
)
//:Listen to all these numbers as frequency, playing them as notes
(
Pbind(\midinote, Pseq(b), \dur, 0.1).play;
)
//:Make chords from the notes, by grouping them in arrays:
(
Pbind(\midinote, Pseq(b.clump(3)), \dur, 0.5).play;
)
//:Arpeggiate with strum.
(
Pbind(\midinote, Pseq(b.clump(3)), \strum, 0.1, \dur, 1).play;
)
//:Sort the notes so that the lowest note is always played first.
(
Pbind(\midinote, Pseq(b.clump(3).collect({ | i | i.sort })), \strum, 0.1, \dur, 1).play;
)
//:
(
/*
Line
XLine

*/

