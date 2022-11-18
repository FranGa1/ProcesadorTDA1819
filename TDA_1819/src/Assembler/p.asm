		.data
A:		.byte	0b01010110
B:		.byte	0b10111010
		.code
		lb r1, A(r0)
		lb r2, B(r0)
		xnor r7, r1, r2
		halt
	