// How to make glissandi with line.
//:Actually: do NOT use Line. The glissando is not heard as a straight line.
{
	SinOsc.ar(
		//     start, end, duration
		Line.kr(24.midicps, (96).midicps, 30),
		0, 0.1
	)
}.play;
//:!!! Xline makes the glissando go straight
{
	SinOsc.ar(
		//     start, end, duration
		XLine.kr(24.midicps, (96).midicps, 30),
		0, 0.1
	)
}.play;
//:If you want to start a line or stop a line while the
// synth (sound) is already playing, then you need to control
// the synth from another synth which you can start and stop when you want.
// This second synth is a control synth, and runs in control rate.
// To make the frequency of the audio synth follow the control synth
// output, you must output the control signal to a control bus, and
// map the frequency parameter of the sound synth to that bus.

// ======== trying to explain the whole thing with examples
//:This is the sound synth
// \freq.kr creates a control that we can control either 
a = { SinOsc.ar(\freq.kr(400), 0, 0.1) }.play;
//:This is the bus for controlling the freq parameter;
b = Bus.control;
//:Now we map the synth freq to the bus:
a.map(\freq, b);
//:we do not hear a sound because b was 0 and freq 0 is not audible
//:let us set b to 500 and see if the synth follows
b.set(500);
//:c is a control synth outputting to the bus
c = { Out.kr(b.index, LFNoise0.kr(5).range(400, 800)) }.play;
//:finished the test. Free the control synth
c.free;
//:Now try the Xline;
c = { Out.kr(b.index, XLine.kr(24.midicps, (96).midicps, 30)) }.play;
//:Note you can stop the line at any point:
c.free;
//:now go down


// ================================================================
//

// ================================================================
// Let us package the free - new synth code in a function,
// to avoid retyping the same code many times.
// Because we need to keep c available, it is best to pack
// everyt



c = { Out.kr(b.index, XLine.kr(24.midicps, (96).midicps, 30)) }.play;
//:Note you can stop the line at any point:
c.free;
//:now go down


// ================================================================
//

// ================================================================
// Let us package the free - new synth code in a function,
// to avoid retyping the same code many times.
// Because we need to keep c available, it is best to pack
// everyt




//:frequency of middle c
60.midicps;
//:frequency of a above middle c
(60 + 9).midicps;


b.index;