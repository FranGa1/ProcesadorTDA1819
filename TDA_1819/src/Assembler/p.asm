		.data
A:		.word	20
B:		.byte	0b10111010
		.code
		lb r1, A(r0)
		lb r2, B(r0)
		dsubi r7, r1, 5
		halt
	