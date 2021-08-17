Class {
	#name : #ASEllipse,
	#superclass : #ASShape,
	#instVars : [
		'rx',
		'ry',
		'cx',
		'cy'
	],
	#category : #'Athens-SVG'
}

{ #category : #'as yet unclassified' }
ASEllipse >> cx: aString [ 
"cx = <coordinate>
The x-axis coordinate of the center of the circle.
If the attribute is not specified, the effect is as if a value of '0'  were specified."

	cx := self translateLength: aString
]

{ #category : #'as yet unclassified' }
ASEllipse >> cy: aString [ 

"cy = <coordinate>
The y-axis coordinate of the center of the circle.
If the attribute is not specified, the effect is as if a value of 0 were specified. Animatable: yes."

	cy := self translateLength: aString
]

{ #category : #'as yet unclassified' }
ASEllipse >> ellipseToPhath [
| kappa ox oy conv stream |
"Please refer to https://stackoverflow.com/questions/59011294/ellipse-to-path-convertion-using-javascript for implementation details"
kappa := 0.5522847498.
ox := rx * kappa. "x offset for the control point"
oy := ry * kappa. "y offset for the control point" 
stream := ReadWriteStream on: (String new: 10).
stream << 'M' << (cx - rx) asString << $, << cy asString
	<<'C' << (cx - rx) asString << ', ' << (cy - oy) asString 
		<< ', ' << (cx - ox) asString << ', ' << (cy - ry) asString 
		<< ', ' << cx asString << ', ' << (cy - ry) asString
	<< ',C' << (cx + ox) asString << ', ' << (cy - ry) asString
		<< ', ' << (cx + rx) asString << ', ' << (cy - oy) asString
		<< ', ' << (cx + rx) asString << ', ' << cy asString
	<< ',C' << (cx + rx) asString << ', ' << (cy + oy) asString 
		<< ', ' << (cx + ox) asString << ', ' << (cy + ry) asString
		<< ', ' << cx asString << ', ' << (cy + ry) asString
	<< ',C' << (cx - ox) asString << ', ' << (cy + ry) asString 
		<< ', ' << (cx - rx) asString << ', ' << (cy + oy) asString
		<< ', ' << (cx - rx) asString << ', ' << cy asString 
	<< ',z'.
Transcript show: stream contents; cr.
conv := ASPathConverter new stream: stream contents readStream.
^ conv convertPathData
]

{ #category : #'as yet unclassified' }
ASEllipse >> rx: aString [ 

	rx := self translateLength: aString.
	

]

{ #category : #'as yet unclassified' }
ASEllipse >> ry: aString [ 

	ry := self translateLength: aString.
	

]

{ #category : #'as yet unclassified' }
ASEllipse >> setShapeOn: aCanvas [
	| ellipse |
	ellipse := aCanvas createPath: [:builder |
		self ellipseToPhath do: [:each |
			builder perform: each first withArguments: each second
			]
		].
	aCanvas setShape: ellipse.
]
