		.data
cadena:	.asciiz	"adbgddedfdgch"
carb:	.asciiz	"d"
cant:	.word	0
		.code
		dadd r1, r0, r0 #r1=0
		lb r2, carb(r0) #r2=carb[0]
		daddi r3, r0, 0x30 #r3='h'
		lw r4, cant(r0) #r4=cant 
		lb r5, cadena(r1) #r5=cadena[0]
loop:	bne r5, r2, no_car #si r5!=r2, salta a no_car
		daddi r4, r4, 1 #r4++
no_car:	daddi r1, r1, 1 #r1++
		lb r5, cadena(r1) #r5=cadena[r1]
		sw r4, cant(r0) #cant=r4
		bne r5, r3, loop #si r5!=r3, salta a loop
		sw r4, cant(r0) #cant=r4
		halt
	