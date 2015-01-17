/*
1. 	X
	p1(a,b)
	==> X = p1(a,b)
2.	p1(X,Y)
	p1(Y,36)
	==> X = Y = 36
3.	p1(X,b)
	p1(Y,x)
	==>fail, b won't bind to x
4.	p1(X, p2(9))
	p1(B, B)
	==> X = B = p2(9)
5.	p1(A,p2(A),3)
	p1(4,p2(3),B)
	==> fail, multiple values assiged to same variable.
6.	p1(p2(A),C,3)
	p1(p2(3),p3(B),B)
	==>A=3, B=C=3
7.	foo(p2(a, Y), 2, p3(X, p2(Y,3)))
	foo(A, B, p3(p1(a), A))
	==>fail, multiple assignments to Y.
8.	p1(X, Z, p2(2, X))
	p1(p3(Z, 8), 9, W)
	==>X=p3(z,8),Z=9, W=p2(2,p3(z,8))
9.	p1(p2(a, X), 2, p2(X, 3))
	p1(A, B, p2(a, Y))
	==>A=p2(a, a),B=2,X=a,Y=3
*/
	