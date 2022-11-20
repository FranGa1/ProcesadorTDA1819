		.data
DNI:	.hword	20559
LEG:	.hword	2714
RES_SUB1:	.hword	2714 
RES_SUB2:	.hword	2714
RES_XNOR1:	.hword	2714  
RES_XNOR2:	.hword	2714
		.code
		daddui r7, r0, 0
		lh r1, DNI(r0)
		lh r2, LEG(r0)
		daddui r8, r0, 0xB5C9
		daddui r9, r0, 0b10101110
		dsubi r3, r1, 2714
		dsubi r4, r2, 20559
		slti r7, r3, 0 # si r3 > 0 -> r1 > r2
		beqz r7, RES_NEG 
RES_POS:	xnorr r5, r3, r8 # Caso en que r1 es mayor que r2
		xnorr r6, r4, r9
		neg r10, r4
		jmp fin
RES_NEG:	xnorr r5, r3, r9 # Caso en que r1 es menor que r2
		xnorr r6, r4, r8
		neg r10, r3
fin:	sh r3, RES_SUB1(r0)
		sh r4, RES_SUB2(r0)
		sh r5, RES_XNOR1(r0)
		sh r6, RES_XNOR2(r0)
		halt
	