contract LoopFor2 {
	function testUnboundedForLoop(uint n, uint[] memory b, uint[] memory c) public pure {
		require(n < b.length);
		require(n < c.length);
		require(n > 0 && n < 100);
		b[0] = 900;
		uint[] memory a = b;
		uint i;
		while (i < n) {
			// Accesses are safe but oob is reported due to potential aliasing after c's assignment.
			b[i] = i + 1;
			c[i] = b[i];
			++i;
		}
		assert(b[0] == c[0]); // should fail due to aliasing
		assert(a[0] == 900); // should fail due to aliasing
		assert(b[0] == 900); // should fail due to aliasing
	}
}
// ====
// SMTEngine: all
// SMTIgnoreCex: yes
// SMTSolvers: z3
// ----
// Warning 6368: (346-350): CHC: Out of bounds access happens here.
// Warning 6368: (370-374): CHC: Out of bounds access happens here.
// Warning 6368: (363-367): CHC: Out of bounds access happens here.
// Warning 6368: (397-401): CHC: Out of bounds access happens here.
// Warning 6368: (405-409): CHC: Out of bounds access happens here.
// Warning 6328: (390-410): CHC: Assertion violation happens here.
// Warning 6368: (452-456): CHC: Out of bounds access happens here.
// Warning 6328: (445-464): CHC: Assertion violation happens here.
// Warning 6368: (506-510): CHC: Out of bounds access happens here.
// Warning 6328: (499-518): CHC: Assertion violation happens here.
