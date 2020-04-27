


a = ".()+@&* asdf asdf asdf asdf 123 123 123";


t = "Kalimera mera mera    m";


t[0];

t[0].ascii;

t[0].ascii.midicps;


(freq: t[0].ascii.midicps).play;
(midinote: t[0].ascii + 2).play;
//:
// note: using dictionaries ....
u = (\K: 0, \a: 1, \l: 2, \i: 6, \m: 3, \e: 4, \r: 5, ' ': -5);

//:
{
	(t.reverse ++ t ++ t.reverse ++ t[3..6]) do: { | letter |
		(degree: u[letter.asSymbol], dur: 0.1).play;
		0.15.wait;
	}
	
}.fork;


//:



b = [1, 2, 3, 4, 5];

://:
(
a;

b;

)
//:
(
a[0];

a[1];



)
//:
(
a.size;
)
//: ================================================================
(
// ITERATION
// variants of iteration:
// n do : do something n times
// while : do something while something is true
// aCollection do: iterate through all elements of a collection
// aCollection collect: collect the result of iterating through each element of a collection.
// aCollection inject: special time of collect
//   passes previous result to next iteration.
// Other operations on collections similar to iteration:
// select: select elements for which something is true
// detect: find first element for which something is true
// reject: select elements for which something is FALSE

)
//:+
(
a do: { | s, i |
	[i, s, s.ascii, s.ascii.midicps].postln;
	0.1.wait;
};
)
//:+
(
a do: { | s, i |
	[i, s, s.ascii, s.ascii.midicps].postln;
	(dur: 0.1, freq: s.ascii.midicps).play;
	0.1.wait;
};
)
//:
(
f = {
	{ 
		a do: { | s, i |
			[i, s, s.ascii, s.ascii.midicps].postln;
			(dur: 0.1, freq: s.ascii.midicps).play;
			0.1.wait;
		};
	}.fork;
};
)
//:
(
f = { | dt = 0.1,  df = 1 | 
	{ 
		a do: { | s, i |
			[i, s, s.ascii, s.ascii.midicps].postln;
			(dur: dt, freq: s.ascii.midicps * df).play;
			dt.wait;
		};
	}.fork;
};
)
//:
(
g = { | from = 0 |
	a[from..];
};
)
//:
(
h = { | from = 0, size = 2 |
	a[from..from + size];
};
)
//:
(
h.value(size: 5);
)
//:
(
g.(20);
)
//:
(
//:
i = { | dt = 0.1,  df = 1, from = 0 size = 10, times = 1 | 
	{
		times do: {
		a[from..from + size] do: { | s, i |
			[i, s, s.ascii, s.ascii.midicps].postln;
			(dur: dt, freq: s.ascii.midicps * df).play;
			dt.wait;
		};
		}
	}.fork;
};
)
//:
(
i.value;
)
//:
(
i.(times: 5);
)
//:
(
i.(size: 5, df: 1.5, times: 3);
)
//:using streams as arguments
(
// now we can customize sequences of values in an argument
j = { | dt = 0.1,  df = 1, from = 0 size = 10, times = 1 |
	dt = dt.asStream; // make sure that we have streams
	df = df.asStream;
	{
		times do: {
			a[from..from + size] do: { | s, i |
				// example of using a variable:
				var next_dt; // we need to use dt twice
				// but we can only call next once
				// so we have to store it in a variable
				next_dt = dt.next;
			[i, s, s.ascii, s.ascii.midicps].postln;
			// use .next to get the next element of a stream
			(dur: next_dt, freq: s.ascii.midicps * df.next).play;
			next_dt.next.wait;
		};
		}
	}.fork;
};
)
//:
(
j.value;
)
//:
(
j.(dt: Pseq([1, 1, 2, 1, 3, 1, 2, 1, 5, 5, 5] / 10, inf));
)
//:
(
f
)
//:
(
f.value;
)
//:
(
f.value(0.2);
)
//:
(
f.value(0.15, 0.9);
)
//:
(
f.value(df: 1.5); // change df only !!!
)
//:
(
{
	f.value; // original melody;
	1.wait;
	f.(0.1 * 2);    // melody half speed
	1.wait;
	f.(0.1*2/3, 10/9); // melody 2/3 speed, higher by 10/9
}.fork;
)
//:
(
a isKindOf: String;

a isKindOf: Array;

a isKindOf: Collection;

a isKindOf: ArrayedCollection;

b isKindOf: ArrayedCollection;

Collection.dumpSubclassList

ArrayedCollection.dumpSubclassList;

SequenceableCollection.dumpSubclassList;

b.class;
// changing an array by putting an element in it:
)
//: (substituting an value in a position)
(
a = a.copy;
)
//:
(
a.put(0, $A);
)
//:
(
a.put(1, $B);
)
//:
(
a
)
//:
(
a = a.reverse;
)
//:
(
// ================

// Dictionaries;
// ================
x = (
	freq: 440,
	duration: 1
);
)
//:
(
x[\duration]
)
//:
(
x[\freq];
)
//:
(
x;
)
//:
(
x[\age] = 5;
)
//:
(
x.put(\name, "boulis");
)
//:
(
x;
)
//:
(
y = ();
)
//:
(
y.size;
)
//:
(
x.size;
)
//:
(
Collection.dumpSubclassList;
