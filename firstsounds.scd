//Begins the server...
s.boot;

x.free;
x = {SinOsc.ar}.play;
//Functions can not be freed on their own.
//To free a function, store in variable:
y = x.free;
y.play;

// modulate the frequency with an exponential ramp
{ SinOsc.ar(XLine.kr(2000, 200), 0, 0.5) }.play;

// more complex frequency modulation
{ SinOsc.ar(SinOsc.ar(XLine.kr(1, 1000, 9), 0, 200, 800), 0, 0.25) }.play;

// phase modulation (see also PMOsc)
{ SinOsc.ar(800, SinOsc.ar(XLine.kr(1, 1000, 9), 0, 2pi), 0.25) }.play;

(
z = {SinOsc.ar(700, * 0.125)}.play;
zx = {
	arg freq = 400, amp = 1;
	var sig;
	sig = SinOsc.ar(freq) * amp;
}.play;
)
z.free;
//Random frequency LFO
(
z = {
	var freq, sig;
	freq = LFNoise0.kr(8, 400, 600);
	sig = SinOsc.ar(freq);
}.play;
)

// Random frequency with SynthDef
(
SynthDef.new(\sineTest, {
  arg noiseHz=8;
  var freq, amp, sig;
  freq = LFNoise0.kr(noiseHz).exprange(200,1000);
  amp = LFNoise1.kr(12).exprange(0,0.2,1);
  sig = SinOsc.ar(freq) * amp;
  Out.ar(0, sig);
}).add;
)

x = Synth.new(\sineTest);

x.free;
