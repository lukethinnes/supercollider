//Begins the server...
s.boot;

x.free;
x = {SinOsc.ar(freq: 440, phase: 0, mul: 0.25, add: 0)}.play;
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
SynthDef.new(\pulseTest, {
  arg fund=40, maxPartial=4;
  var amp1, amp2, freq1, freq2, sig1, sig2;
  amp1 = LFPulse.kr(ampHz, 0, 0.12) * 0.75;
  amp2 = LFPulse.kr(ampHz, 0, 0.12) * 0.75;
  freq1 = LFNoise0.kr(4).exprange(fund, fund*maxPartial).round(fund);
  freq2 = LFNoise0.kr(4).exprange(fund, fund*maxPartial).round(fund);
  freq1 = freq1 * LFPulse.kr(8, add:1);
  freq2 = freq2 * LFPulse.kr(6, add:1);
  sig1 = Pulse.ar(freq1, width, amp1);
  sig2 = Pulse.ar(freq2, width, amp2);
  sig1 = FreeVerb.ar(sig1, 0.7, 0.8, 0.25);
  sig2 = FreeVerb.ar(sig1, 0.7, 0.8, 0.25);
  Out.ar(0, sig1);
  Out.ar(1, sig2);
}).add;
)

x = Synth.new(\pulseTest);

x.free;

s.quit;
