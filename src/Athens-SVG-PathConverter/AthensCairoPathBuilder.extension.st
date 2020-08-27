Extension { #name : #AthensCairoPathBuilder }

{ #category : #'*Athens-SVG-PathConverter' }
AthensCairoPathBuilder >> arcDegreeStart: aStartAngle sweep: aSweepAngle centerX: anX y: aY radius: aRadius [ 
	^self 
		arcRadianStart: aStartAngle degreesToRadians
		sweep: aSweepAngle degreesToRadians
		centerX: anX
		y: aY
		radius: aRadius
]

{ #category : #'*Athens-SVG-PathConverter' }
AthensCairoPathBuilder >> arcRadianStart: aStartAngle sweep: aSweepAngle centerX: anX y: aY radius: aRadius [ 
	| endAngle |
	
	endAngle := aStartAngle + aSweepAngle.
	aSweepAngle positive 
		ifTrue: 
			[ self arcCenterX: anX centerY: aY radius: aRadius startAngle: aStartAngle endAngle: endAngle ]
		ifFalse: 
			[ self arcNegativeCenterX: anX centerY: aY radius: aRadius startAngle: aStartAngle endAngle: endAngle ].
]

{ #category : #'*Athens-SVG-PathConverter' }
AthensCairoPathBuilder >> ellipticalArc3: radii xrot: xAxisRotation large: largeArcFlag sweep: sweepFlag to: theEndPoint [

"	 self cwArcTo: pt angle: 45 degreesToRadians  "
	
	| rx ry x1 y1 x2 y2 dx2 dy2 phi cosAngle sinAngle arx ary coeff cx1 cy1 ux uy vx vy sign xPrime1 yPrime1 radical startAngle sweepAngle cx cy aPoint |
	aPoint := lastControlPoint.
	
	rx := radii x.
	ry := radii y.
	
	(rx - ry) abs < 1e-7 ifTrue: [
		^self "self computeCircleArcAt: aPoint"].
	
	x1 := aPoint x.
	y1 := aPoint y.
	x2 := theEndPoint x.
	y2 := theEndPoint y.
	dx2 := (x1 - x2) / 2.
	dy2 := (y1 - y2) / 2.
	phi := (xAxisRotation \\ 360) degreesToRadians.
	cosAngle := phi cos.
	sinAngle := phi sin.
	xPrime1 := cosAngle * dx2 + (sinAngle * dy2).
	yPrime1 := cosAngle * dy2 - (sinAngle * dx2).

	"Ensure radii are positive"
	arx := rx abs.
	ary := ry abs.


	"Ensure radii are large enough"
	"lambda := (x1 squared / arx squared) + (y1 squared / ary squared).
	lambda > 1 ifTrue: [
		arx := arx * lambda sqrt.
		ary := ary * lambda sqrt]."

	"Step 2: Compute (cx1, cy1) "
	radical := (arx squared * ary squared - (arx squared * yPrime1 squared)
				- (ary squared * xPrime1 squared))
					/ (arx squared * yPrime1 squared + (ary squared * xPrime1 squared)).
	radical abs <= 1e-4 ifTrue: [radical := 0.0].
	coeff := radical sqrt.
	sweepFlag == largeArcFlag ifTrue: [coeff := coeff negated].
	cx1 := coeff * arx * yPrime1 / ary.
	cy1 := (coeff * ary * xPrime1 / arx) negated.

	"Step 3: Compute (cx, cy)"
	cx := cosAngle * cx1 - (sinAngle * cy1) + ((x1 + x2) / 2).
	cy := sinAngle * cx1 + (cosAngle * cy1) + ((y1 + y2) / 2).

	"Step 4: Compute startAngle and sweepAngle"
	ux := (xPrime1 - cx1) / arx.
	uy := (yPrime1 - cy1) / ary.
	vx := (xPrime1 negated - cx1) / arx.
	vy := (yPrime1 negated - cy1) / ary.
	sign := ux * vy - (uy * vx) < 0 ifTrue: [-1] ifFalse: [1].
	startAngle := ((ux / (ux squared + uy squared) sqrt) arcCos * uy sign)
				radiansToDegrees \\ 360.
	sweepAngle := (((ux * vx + (uy * vy))
				/ ((ux squared + uy squared) * (vx squared + vy squared)) abs sqrt) asFloat
				arcCos * sign)
				radiansToDegrees \\ 360.
	(sweepAngle abs < 180 and: [largeArcFlag])
		ifTrue: 
			[sweepAngle < 0
				ifTrue: [sweepAngle := 360 + sweepAngle]
				ifFalse: [sweepAngle := sweepAngle - 360]].
	sweepFlag
		ifTrue: [sweepAngle < 0 ifTrue: [sweepAngle := sweepAngle + 360]]
		ifFalse: [sweepAngle > 0 ifTrue: [sweepAngle := sweepAngle - 360]].
	
		

]

{ #category : #'*Athens-SVG-PathConverter' }
AthensCairoPathBuilder >> ellipticalArc: radii xrot: xAxisRotation large: largeArcFlag sweep: sweepFlag to: theEndPoint [

"	 self cwArcTo: pt angle: 45 degreesToRadians  "
	
	| rx ry x1 y1 x2 y2 dx2 dy2 phi cosAngle sinAngle arx ary coeff cx1 cy1 ux uy vx vy sign xPrime1 yPrime1 radical startAngle sweepAngle cx cy aPoint lFlag swFlag isRelative aCenter |
	aPoint := 0@0.
	
	lFlag := false.
	swFlag := false.
	
	rx := radii x.
	ry := radii y.
		
	x1 := aPoint x.
	y1 := aPoint y.
	x2 := theEndPoint x.
	y2 := theEndPoint y.
	dx2 := (x1 - x2) / 2.
	dy2 := (y1 - y2) / 2.
	phi := (xAxisRotation \\ 360) degreesToRadians.
	cosAngle := phi cos.
	sinAngle := phi sin.
	xPrime1 := cosAngle * dx2 + (sinAngle * dy2).
	yPrime1 := cosAngle * dy2 - (sinAngle * dx2).

	"Ensure radii are positive"
	arx := rx abs.
	ary := ry abs.


	"Ensure radii are large enough"
	"lambda := (x1 squared / arx squared) + (y1 squared / ary squared).
	lambda > 1 ifTrue: [
		arx := arx * lambda sqrt.
		ary := ary * lambda sqrt]."

	"Step 2: Compute (cx1, cy1) "
	radical := (arx squared * ary squared - (arx squared * yPrime1 squared)
				- (ary squared * xPrime1 squared))
					/ (arx squared * yPrime1 squared + (ary squared * xPrime1 squared)).
	radical "abs" <= 1e-4 ifTrue: [radical := 0.0].

	coeff := radical sqrt.
	swFlag == lFlag ifTrue: [coeff := coeff negated].
	cx1 := coeff * arx * yPrime1 / ary.
	cy1 := (coeff * ary * xPrime1 / arx) negated.

	"Step 3: Compute (cx, cy)"
	cx := cosAngle * cx1 - (sinAngle * cy1) + ((x1 + x2) / 2).
	cy := sinAngle * cx1 + (cosAngle * cy1) + ((y1 + y2) / 2).

	"Step 4: Compute startAngle and sweepAngle"
	ux := (xPrime1 - cx1) / arx.
	uy := (yPrime1 - cy1) / ary.
	vx := (xPrime1 negated - cx1) / arx.
	vy := (yPrime1 negated - cy1) / ary.
	sign := ux * vy - (uy * vx) < 0 ifTrue: [-1] ifFalse: [1].
	startAngle := ((ux / (ux squared + uy squared) sqrt) arcCos * uy sign)
				radiansToDegrees \\ 360.
	sweepAngle := (((ux * vx + (uy * vy))
				/ ((ux squared + uy squared) * (vx squared + vy squared)) abs sqrt) asFloat
				arcCos * sign)
				radiansToDegrees \\ 360.
	(sweepAngle abs < 180 and: [lFlag])
		ifTrue: 
			[sweepAngle < 0
				ifTrue: [sweepAngle := 360 + sweepAngle]
				ifFalse: [sweepAngle := sweepAngle - 360]].
	swFlag
		ifTrue: [sweepAngle < 0 ifTrue: [sweepAngle := sweepAngle + 360]]
		ifFalse: [sweepAngle > 0 ifTrue: [sweepAngle := sweepAngle - 360]].
		
	isRelative := false.
	aCenter := isRelative ifTrue: [ endPoint + (cx@cy)] ifFalse: [cx@cy].
	
	self arcDegreeStart: startAngle sweep: sweepAngle centerX: aCenter x y: aCenter y radius: rx abs.
	
endPoint := self toAbsolute: theEndPoint.

"self arcDegreeStart: startAngle sweep: sweepAngle centerX: cx y: cy radius: 1.0 
"		
"	self arcCenterX: xc centerY: yc radius: radius startAngle: angle1 endAngle: angle2  
"
]

{ #category : #'*Athens-SVG-PathConverter' }
AthensCairoPathBuilder >> ellipticalArc: radii xrot: xAxisRotation large: largeArcFlag sweep: sweepFlag to: theEndPoint relative: isRelative [

"	 self cwArcTo: pt angle: 45 degreesToRadians  "
	
	| rx ry x1 y1 x2 y2 dx2 dy2 arx ary coeff cx1 cy1 ux uy vx vy sign xPrime1 yPrime1 radical  startAngle sweepAngle cx cy aPoint lFlag swFlag aCenter uySign |
	
	
	aPoint := isRelative
				ifTrue: [0.0 @ 0.0]
				ifFalse: [endPoint].
	
	lFlag := false.
	swFlag := sweepFlag = 1.0.
	
	rx := radii x.
	ry := radii y.
		
	x1 := aPoint x.
	y1 := aPoint y.
	x2 := theEndPoint x.
	y2 := theEndPoint y.
	dx2 := (x1 - x2) / 2.
	dy2 := (y1 - y2) / 2.
"	phi := (xAxisRotation \\ 360) degreesToRadians.
	cosAngle := phi cos.
	sinAngle := phi sin.
	xPrime1 := cosAngle * dx2 + (sinAngle * dy2).
	yPrime1 := cosAngle * dy2 - (sinAngle * dx2)."
	
	xPrime1 := dx2.
	yPrime1 := dy2.

	"Ensure radii are positive"
	arx := rx abs.
	ary := ry abs.


	"Ensure radii are large enough"
	"lambda := (x1 squared / arx squared) + (y1 squared / ary squared).
	lambda > 1 ifTrue: [
		arx := arx * lambda sqrt.
		ary := ary * lambda sqrt]."

	"Step 2: Compute (cx1, cy1) "
	radical := (arx squared * ary squared - (arx squared * yPrime1 squared)
				- (ary squared * xPrime1 squared))
					/ (arx squared * yPrime1 squared + (ary squared * xPrime1 squared)).
	radical abs <= 1e-4 ifTrue: [radical := 0.0].
	coeff := radical abs sqrt.
	sweepFlag == largeArcFlag ifTrue: [coeff := coeff negated].
	cx1 := coeff * yPrime1.
	cy1 := (coeff * xPrime1) negated.

	"Step 3: Compute (cx, cy)"
	cx := cx1 + ((x1 + x2) / 2).
	cy := cy1 + ((y1 + y2) / 2).

	"Step 4: Compute startAngle and sweepAngle"
	ux := (xPrime1 - cx1) / arx.
	uy := (yPrime1 - cy1) / ary.
	vx := (xPrime1 negated - cx1) / arx.
	vy := (yPrime1 negated - cy1) / ary.
	sign := ux * vy - (uy * vx) <= 0 ifTrue: [-1] ifFalse: [1].
	uySign := uy = 0 ifTrue: [1] ifFalse: [uy sign].
	startAngle := ((ux / (ux squared + uy squared) sqrt) arcCos * uySign)
				radiansToDegrees \\ 360.
	sweepAngle := (((ux * vx + (uy * vy))
				/ ((ux squared + uy squared) * (vx squared + vy squared)) abs sqrt) asFloat
				arcCos * sign)
				radiansToDegrees \\ 360.
	(sweepAngle abs < 180 and: [lFlag])
		ifTrue: 
			[sweepAngle < 0
				ifTrue: [sweepAngle := 360 + sweepAngle]
				ifFalse: [sweepAngle := sweepAngle - 360]].
	swFlag
		ifTrue: [sweepAngle < 0 ifTrue: [sweepAngle := sweepAngle + 360]]
		ifFalse: [sweepAngle > 0 ifTrue: [sweepAngle := sweepAngle - 360]].
				
	aCenter := isRelative ifTrue: [ endPoint + (cx@cy)] ifFalse: [cx@cy].
	
	self arcDegreeStart: startAngle sweep: sweepAngle centerX: aCenter x y: aCenter y radius: rx abs.
	
endPoint := self toAbsolute: theEndPoint.

"self arcDegreeStart: startAngle sweep: sweepAngle centerX: cx y: cy radius: 1.0 
"		
"	self arcCenterX: xc centerY: yc radius: radius startAngle: angle1 endAngle: angle2  
"
]
