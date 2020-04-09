

Server.default.boot;


1 + 1;
//:
Env.adsr;
//:
Env.adsr.plot;
//:
Env.adsr.test;
//:
Env.sine.test;
//:
Env.sine.plot;
//:
SynthDef("envtest1", {
	var src;
	src = WhiteNoise.ar(0.1);
	Out.ar(0, src);
}).add;
//:
a = Synth("envtest1");
//:
a;
//:
a.release;
//:
a.release(5);
//:
a release: 5;
//:
a release: 0.5;
//:
a.free;
//:
SynthDef("envtest1", {
	var src, env;
	src = WhiteNoise.ar(0.1);
	env = Env.adsr;
	Out.ar(0, src * env.kr(2, \gate.kr(1)));
}).add;
//:
{
	var sound1;
	10 do: {
		sound1 = Synth("envtest1");
		0.1.wait;
		sound1 release: 0.05;
		0.1.wait;
	}
}.fork;
//:
{
	var sound1;
	50 do: {
		sound1 = Synth("envtest1");
		[0.1, 0.2, 0.4].choose.wait;
		sound1 release: 0.05;
		0.1.wait;
	}
}.fork;
//:
{
	var sound1, dur;
	dur = [0.1, 0.2];
	inf do: { | i |
		sound1 = Synth("envtest1");
		(dur@@i).wait;
		sound1 release: 0.05;
		0.1.wait;
	}
}.fork;
//:
// ONSET
// onset = the (perceived) beginning of a note
// calculating the distance between onsets in the
// above examples:
/*
	Take the duration of the release
	and subtract it from the wait time to the next onset.
*/
// Example solution of the exercise
// (applying the algorithm above)
//:
// release = 0.05
// wait time = 0.1
var release, waittime;
release = 0.05;
waittime = 0.1;
waittime - release;
//: What is a pause?
// a pause is the time interval between the end of
// a note and the beginning of the next note
// BUT we may sometimes consider the pause to be
// the distance between the onsets of two consecutive
// sounds.
// This is NOT correct!
// The distane between onsets of two consecutive sounds
// is called onset time interval.
//:WILL THIS WORK AS EXPECTED?????
//Yes. The sounds will overlap. There will be no pauses
{
	var sound1, dur;
	dur = [0.1, 0.2];
	inf do: { | i |
		sound1 = Synth("envtest1");
		(dur@@i).wait;
		sound1 release: 0.3;
		0.1.wait;
	}
}.fork;
//:Now let us code this in a different way
// use a stream. 
{
	var sound1, dur;
	dur = Pseq([0.1, 0.2], inf).asStream; // !!!
	inf do: { | i |
		sound1 = Synth("envtest1");
		dur.next.wait; // !!!
		sound1 release: 0.3;
		0.1.wait;
	}
}.fork;
//:lets try using the stream for the loop. 
{
	var sound1, dur;
	dur = Pseq([0.1, 0.2], inf).asStream; // !!!
	dur do: { | i |  // !!!
		sound1 = Synth("envtest1");
		i.wait;  //
		sound1 release: 0.3;
		0.1.wait;
	}
}.fork;
//:some stuff one can do with streams
//and why we use them... (the power of streams...)
// 1. random instead of sequential
{
	var sound1, dur;
	dur = Prand([0.1, 0.2], inf).asStream; // !!!
	dur do: { | i |  // !!!
		sound1 = Synth("envtest1");
		i.wait;  //
		sound1 release: 0.3;
		0.1.wait;
	}
}.fork;
//:2. NESTING is the power of streams / patterns
{
	var sound1, dur;
	dur = Pseq([
		//		Prand([0.1, 0.2], 6),
		Pseq((0.01, 0.02 .. 0.4), 1),
		Pseq((0.4, 0.39 .. 0.01), 1)
	], inf).asStream; // !!!
	dur do: { | i |  // !!!
		sound1 = Synth("envtest1");
		i.wait;  //
		sound1 release: 0.05;
		0.1.wait;
	}
}.fork;
//:==================================================
// ======= USING PATTERNS WITH PBIND
// Pbind is a powerful pattern player
// A very simple Pbind:
p = Pbind(\instrument, \envtest1, \dur, 0.1).play;
//:changing the pause between sounds (notes)
p = Pbind(\instrument, \envtest1, \dur, 2, \legato, 0.5).play;
//:Release does not seem to be easily reachable:
p = Pbind(\instrument, \envtest1, \dur, 2, \legato, 0.5, \release, 0.1).play;
//:Playing the above duration pattern with a pbind
p = Pbind(\instrument, \envtest1, \dur,
	Pseq([
		Pseq((0.01, 0.02 .. 0.2), 1),
		Pseq((0.2, 0.19 .. 0.01), 1)
	], inf),
	\legato, 0.5, \release, 0.1
).play;
//:================================================================
// Next level: Play many pbinds.
//:Step 1: Play each pattern 3 times (same number of times).
{
	var durpattern;
	durpattern = Pseq([
		Pseq((0.01, 0.02 .. 0.2), 1),
		Pseq((0.2, 0.19 .. 0.01), 1)
	], 3);
	5 do: {
		Pbind(\instrument, \envtest1, \dur, durpattern).play;
		2.rrand(7).wait;
	}
}.fork;
//:
// Use a filter to make each patern play with a different sound.
// NEW INSTRUMENT SynthDef
SynthDef("ringtest1", { | freq = 440 | // frequency of the filter
	var src, env;
	src = Ringz.ar(
		WhiteNoise.ar(0.02),
		freq, 0.5
	);
	env = Env.adsr;
	// src.dup : duplicate the source. It comes out as stereo left-right
	Out.ar(0, src.dup * env.kr(2, \gate.kr(1))); // cheap stereo
}).add
//: test the sound first.
{
	var sound;
	sound = Synth("ringtest1");
	1.wait;
	sound release: 2;
}.fork;
//:a second short test: testing frequency
{
	50 do: {
		var sound;
		sound = Synth("ringtest1", [freq: 40.rrand(90).midicps]);
		0.1.wait;
		sound release: 2;
		0.2.wait		
	}
}.fork;

//: use a diatonic scale for our next experiment
{
	var durpattern;
	durpattern = Pseq([
		Pseq((0.01, 0.02 .. 0.2), 1),
		Pseq((0.2, 0.19 .. 0.01), 1)
	], 3);
	5 do: {
		Pbind(\instrument, \ringtest1, \dur, durpattern,
			\degree, (-10 .. 20).choose
		).play;
		2.rrand(7).wait;
	}
}.fork;
//: use a diatonic scale with random pattern for our next experiment
{
	var durpattern;
	durpattern = Pseq([
		Pseq((0.01, 0.02 .. 0.2), 1),
		Pseq((0.2, 0.19 .. 0.01), 1)
	], 3);
	5 do: {
		Pbind(\instrument, \ringtest1, \dur, durpattern,
			\degree, Prand((-10 .. 20), inf)
		).play;
		2.rrand(7).wait;
	}
}.fork;
//:
//: use a diatonic scale with brownian motion pattern for our next experiment
// this will produce scale-wise motion by moving 1 degree each time.
{
	var durpattern;
	durpattern = Pseq([
		Pseq((0.01, 0.02 .. 0.2), 1),
		Pseq((0.2, 0.19 .. 0.01), 1)
	], 3);
	5 do: {
		Pbind(\instrument, \ringtest1, \dur, durpattern,
			\degree, Pbrown(-10, 20, 1, inf)
		).play;
		2.rrand(7).wait;
	}
}.fork;

//:NOTES
// duration of note before release =
// realdur = dur * legato.
// So the note is released after realdur, and keeps sounding for the
// built in duration of the release time of the synth!
//:How to see the release of an envelope:
Env.adsr.inspect;
Env.adsr.times;
Env.adsr.times.last;











