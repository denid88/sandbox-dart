// Data Locality demo. Run:
//   dart run data_locality.dart                       (JIT)
//   dart compile exe data_locality.dart -o bench && ./bench   (AOT, closer to Flutter release)
import 'dart:math';
import 'dart:typed_data';

const int count = 1000000; // particles
const double dt = 0.016;

// ---------- 1. OOP: list of references to heap objects ----------
class Particle {
  Particle(this.vx, this.vy);
  double x = 0, y = 0;
  final double vx, vy;
}

void updateObjects(List<Particle> ps) {
  for (final p in ps) {
    p.x += p.vx * dt;
    p.y += p.vy * dt;
  }
}

// ---------- 2. Data Locality: each field in a contiguous typed array ----------
class Particles {
  Particles(int n)
      : x = Float32List(n),
        y = Float32List(n),
        vx = Float32List(n),
        vy = Float32List(n);

  final Float32List x, y, vx, vy;

  void update() {
    for (var i = 0; i < x.length; i++) {
      x[i] += vx[i] * dt;
      y[i] += vy[i] * dt;
    }
  }
}

// ---------- 3. Traversal order over an RGBA image ----------
int sumRedRows(Uint8List px, int w, int h) {
  var sum = 0;
  for (var y = 0; y < h; y++) {
    for (var x = 0; x < w; x++) {
      sum += px[(y * w + x) * 4]; // sequential memory access
    }
  }
  return sum;
}

int sumRedColumns(Uint8List px, int w, int h) {
  var sum = 0;
  for (var x = 0; x < w; x++) {
    for (var y = 0; y < h; y++) {
      sum += px[(y * w + x) * 4]; // jumps w * 4 bytes every step
    }
  }
  return sum;
}

// ---------- Tiny benchmark helper ----------
void measure(String name, int repeats, void Function() body) {
  body(); // warm-up so the JIT compiles the hot loop first
  final sw = Stopwatch()..start();
  for (var i = 0; i < repeats; i++) {
    body();
  }
  print('${name.padRight(30)} ${sw.elapsedMilliseconds} ms');
}

void main() {
  final rnd = Random(42);

  // Same data in three layouts
  final ordered = List.generate(
    count,
    (_) => Particle(rnd.nextDouble(), rnd.nextDouble()),
  );
  final shuffled = [...ordered]..shuffle(rnd); // same objects, random memory order
  final arrays = Particles(count);
  for (var i = 0; i < count; i++) {
    arrays.vx[i] = ordered[i].vx;
    arrays.vy[i] = ordered[i].vy;
  }

  print('--- Particles: $count items, 50 frames ---');
  measure('List<Particle> (allocation order)', 50, () => updateObjects(ordered));
  measure('List<Particle> (shuffled)', 50, () => updateObjects(shuffled));
  measure('Float32List (SoA)', 50, arrays.update);

  const w = 4000, h = 3000;
  final px = Uint8List(w * h * 4);
  for (var i = 0; i < px.length; i++) {
    px[i] = i & 0xFF;
  }

  var sink = 0; // keeps results alive so the compiler can't drop the work
  print('\n--- Image ${w}x$h RGBA, 10 passes ---');
  measure('Row by row', 10, () => sink ^= sumRedRows(px, w, h));
  measure('Column by column', 10, () => sink ^= sumRedColumns(px, w, h));

  print('\nchecksum: ${ordered[0].x + arrays.x[0] + sink}');
}