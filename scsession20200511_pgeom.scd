// =====================================================================
// SuperCollider Workspace
// =====================================================================

//:
a = Pbind( 
	\freq, Pgeom(400, 1.0001, inf), 
	\dur, 0.01, 
	//\legato, 2, 
	\amp, 0.3 
).trace.play;
//:
a = Pmono(
	\default,
	\freq, Pgeom(400, 1.0001, inf), 
	\dur, 0.01, 
	\amp, 0.3 
).trace.play;
//:
SynthDef('notviolin', { | freq = 440, amp = 0.1, gate = 1 |
	var env, src;
	env = Env.adsr;
	src = LFSaw.ar(freq, 0, amp).dup;
	Out.ar(0, src * env.kr(2, gate))
}).add;
//:
SynthDef(\sineagainhaha, { | freq = 440, amp = 0.1, gate = 1 |
	var env, src;
	env = Env.adsr;
	src = SinOsc.ar(freq, 0, amp).dup;
	Out.ar(0, src * env.kr(2, gate))
}).add;
//:
SynthDef(\anicepulse, { | freq = 440, amp = 0.1, gate = 1 |
	var env, src;
	env = Env.adsr;
	src = LFPulse.ar(freq, 0, 0.5, amp).dup;
	Out.ar(0, src * env.kr(2, gate))
}).add;
//:
a = Synth('notviolin', [freq: 100]);
//:
a = Synth('sineagainhaha');
//:
a = Synth('anicepulse', [freq: 100]);
//:
a release: 5;
//:
a = Pmono(
	\notviolin,
	\freq, Pgeom(400, 1.001, inf), 
	\dur, 0.01, 
	\amp, 0.1
).trace.play;

//:
a = Pmono(
	\anicepulse,
	\freq, Pgeom(400, 1.001, inf), 
	\dur, 0.01, 
	\amp, 0.1
).trace.play;
//:
a = Pbind(
	\freq, Pgeom(400, 1.01, inf), 
	\dur, 0.01, 
	//\legato, 2, 
	\amp, 0.3 
).trace.play;
//:
\default +> \qualitytest;
//:
p = Pmono(\default, \dur, 0.2, \freq, Pwhite(1,8) * 100 ).play
//:
p.stop
//:
// multi channel expansion is supported:
p = Pmono(\default, \dur, 0.2, \freq, Pwhite(1,8) * 100, \detune, [0,2,5,1]).play
//:
p.stop
//:
Server.default.scope;
//:
Server.default.freqscope;
//:
2.pow(2);
//:
g = { | startpitch = 400, endpitch = 800, dt = 1 |	
	
};
//:
p = Pgeom(400, 1.001, inf);
s = p.asStream;
s.nextN(10);
//:
p = Pgeom(400, 1.001, inf);
s = p.asStream;
a = s.nextN(1000000);
l = a detect: { | e | e > 1000 };
i = a indexOf: l;
a[i - 1];
//:The answer is then:
p = Pgeom(400, 1.001, 916);
//:
x = { | freq = 400, incfactor = 1.001, steps = 100, dt = 0.01 | 
	var pattern;
	pattern = Pgeom(freq, incfactor, steps);
	Pmono(\default,
		\freq, pattern,
		\dur, dt
		//, amp ... 
	).play;
};
//:
x.value(steps: 100);
//:
x.value(incfactor: 1.01, steps: 100);
//:
//:
x.value(freq: 3000, incfactor: 0.99, steps: 500);
//:combine the above in a small score
{
	x.value(steps: 1000);
	2.wait;
	x.value(incfactor: 1.01, steps: 200);
	1.4.wait;
	x.value(freq: 3000, incfactor: 0.99, steps: 500);
}.fork;
//:
//:combine the above in a small score
{
	49 do: {
		x.value(500 rrand: 2000, 0.98 rrand: 1.01, 20 rrand: 200, 0.05 rrand: 0.1);
		(0.5 rrand: 3).wait;
	}
}.fork;




