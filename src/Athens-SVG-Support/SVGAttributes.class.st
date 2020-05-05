"
SVGAttributes collect all attributes of any XML.Node when creating the SVGObjects from the result of the XMLParser.
While all instance variables refer to real SVG display attributes, instVar 'domainAttribtes' will contain parametes of SVGObjects, like coordinates, paths etc. 

Instance Variables:
	display		<String>				one of: inline block | list-item | run-in | compact | marker | table | inline-table | table-row-group | table-header-group | table-footer-group | table-row | table-column-group | table-column | table-cell | table-caption | none | inherit
	document		<SVGDocument>		description of document
	domainAttributes	<Dictionary>		description of domainAttributes
	fill			<ColorValue | String>	besides a ColorValue, the String 'none' can be here
	fillOpacity		<Number>				the opacity of the fill
	fillRule		<String>				one of: nonzero | evenodd | inherit
	fontFamily		<Object | ProtoObject>	description of fontFamily
	fontSize		<Number>	description of fontSize
	fontWeight		<Number>	description of fontWeight
	height		<Number>	description of height
	lineHeight		<Number>	description of lineHeight
	noFill			<Object | ProtoObject>	description of noFill
	stroke		<ColorValue>			the color of the line
	strokeLineCap	<String>				one of: butt | round | square | inherit
	strokeLineJoin	<String>				one of: miter | round | bevel | inherit
	strokeMiterlimit	<Number>				a value >= 1
	strokeOpacity	<Number>				the opacity of the line
	strokeWidth	<Number>				the line width
	width			<Number>				description of width
	x			<Number>				description of x
	y			<Number>				description of y


"
Class {
	#name : #SVGAttributes,
	#superclass : #Object,
	#instVars : [
		'strokeWidth',
		'fillRule',
		'fill',
		'strokeLineJoin',
		'strokeMiterlimit',
		'strokeLineCap',
		'stroke',
		'fillOpacity',
		'strokeOpacity',
		'noFill',
		'fontSize',
		'fontFamily',
		'fontWeight',
		'lineHeight',
		'x',
		'y',
		'width',
		'height',
		'display',
		'document',
		'domainAttributes'
	],
	#category : #'Athens-SVG-Support'
}

{ #category : #'instance creation' }
SVGAttributes class >> new [
	"Answer a newly created and initialized instance."

	^super new initialize
]

{ #category : #'VisualWorks metadata' }
SVGAttributes class >> visualWorksMetadata [

	^ #(
		'namespace' 'SVGViewer'
	)

]

{ #category : #'xml support' }
SVGAttributes >> colorAttribute3: aString [

	| theRed theGreen theBlue |
	theRed := (ByteArray
				fromHexString: (String with: aString first) , (String with: aString first))
					first / 255.0.
	theGreen := (ByteArray fromHexString: (String with: aString second)
						, (String with: aString second))
				first / 255.0.
	theBlue := (ByteArray
				fromHexString: (String with: aString third) , (String with: aString third))
					first / 255.0.
	^Color r: theRed g: theGreen b: theBlue
]

{ #category : #colors }
SVGAttributes >> colorBlend [
	^ (self fill respondsTo: #red)
		ifTrue: [ "work to be done for gradients"
			Color
				red: self fill red
				green: self fill green
				blue: self fill blue
				alpha: self fillOpacity	"VW_TRANSLATION:CairoGraphics.ColorBlend:CairoGraphics_ColorBlend" ]
		ifFalse: [ self fill colorBlendAt: 1 ]
]

{ #category : #'xml support' }
SVGAttributes >> decodeColorAttribute: aStringFromXML [

	| aString anArray |
	aString := aStringFromXML.
	aString = 'none' ifTrue: [
		^Color transparent].
	(CssClass cssColorNamed: aString) ifNotNil: [:col | ^col].
	(Color respondsTo: aString asSymbol)
		ifTrue: [^Color perform: aString asSymbol].
	('url*' match: aString)
		ifTrue: [^self gradientFor: (aString copyFrom: 6 to: aString size - 1)].
	aString := (aString copyFrom: 2 to: aString size) asUppercase.
	aString size = 3 ifTrue: [^self colorAttribute3: aString].
	anArray := ByteArray fromHexString: aString.
	^Color
		r: anArray first / 255.0
		g: anArray second / 255.0
		b: anArray third / 255.0
]

{ #category : #colors }
SVGAttributes >> defaultColor [

	^Color black
]

{ #category : #accessing }
SVGAttributes >> display [

	^display
]

{ #category : #accessing }
SVGAttributes >> display: anObject [

	display := anObject
]

{ #category : #testing }
SVGAttributes >> doNotDisplay [

	^display = 'none'
]

{ #category : #accessing }
SVGAttributes >> document [

	^document
]

{ #category : #accessing }
SVGAttributes >> document: anObject [

	document := anObject
]

{ #category : #'xml support' }
SVGAttributes >> domainAttributeAt: aName put: aRawValue [

	self domainAttributes at: aName put: aRawValue
]

{ #category : #'xml support' }
SVGAttributes >> domainAttributes [

	^domainAttributes ifNil: [domainAttributes := Dictionary new]
]

{ #category : #accessing }
SVGAttributes >> fill [
	"https://www.w3.org/TR/2011/REC-SVG11-20110816/painting.html#FillProperties"

	^fill ifNil: [Color black]
]

{ #category : #accessing }
SVGAttributes >> fill: anObject [

	| target |
	anObject = 'none' ifTrue: [^self noFill: true].
	anObject isString
		ifTrue: [target := self decodeColorAttribute: anObject]
		ifFalse: [target := anObject].
	fill := target
]

{ #category : #accessing }
SVGAttributes >> fillOpacity [

	^fillOpacity
]

{ #category : #accessing }
SVGAttributes >> fillOpacity: anObject [

	fillOpacity := anObject
]

{ #category : #accessing }
SVGAttributes >> fillRule [

	^fillRule
]

{ #category : #accessing }
SVGAttributes >> fillRule: anObject [

	fillRule := anObject
]

{ #category : #accessing }
SVGAttributes >> fontFamily [

	^fontFamily
]

{ #category : #accessing }
SVGAttributes >> fontFamily: anObject [

	fontFamily := anObject
]

{ #category : #accessing }
SVGAttributes >> fontSize [

	^fontSize
]

{ #category : #accessing }
SVGAttributes >> fontSize: anObject [

	fontSize := anObject
]

{ #category : #accessing }
SVGAttributes >> fontWeight [

	^fontWeight
]

{ #category : #accessing }
SVGAttributes >> fontWeight: anObject [

	fontWeight := anObject
]

{ #category : #accessing }
SVGAttributes >> getFill [
	(self fill isNil
		and: [ self fillOpacity isNil and: [ self fillRule ] ]) isNil
		ifTrue: [ ^ nil ].
	self fill
		ifNotNil: [ self fillOpacity
				ifNil: [ ^ self fill ]
				ifNotNil: [ ^ self colorBlend ] ].
	self fill isNil
		ifTrue: [ self fillOpacity isNil
				ifTrue: [ ^ self defaultColor ]
				ifFalse: [ ^ Color
						red: 0.0
						green: 0.0
						blue: 0.0
						alpha: self fillOpacity	"VW_TRANSLATION:CairoGraphics.ColorBlend:CairoGraphics_ColorBlend" ] ].
	^ self defaultColor
]

{ #category : #accessing }
SVGAttributes >> getStroke [
	self stroke
		ifNil:
			[ ^ nil	"(self noFill notNil and: [self noFill]) ifTrue: [self defaultColor] ifFalse: [nil]" ].
	^ self strokeOpacity
		ifNil: [ self stroke ]
		ifNotNil: [ Color
				red: self stroke red
				green: self stroke green
				blue: self stroke blue
				alpha: self strokeOpacity	"VW_TRANSLATION:CairoGraphics.ColorBlend:CairoGraphics_ColorBlend" ]
]

{ #category : #'xml support' }
SVGAttributes >> gradientFor: aString [

	| theObject |
	theObject := self document defs objectAt: aString.
	^theObject asCairoGradient
]

{ #category : #accessing }
SVGAttributes >> height [

	^height
]

{ #category : #accessing }
SVGAttributes >> height: anObject [

	height := anObject isString ifTrue: [anObject asNumber] ifFalse: [anObject]
]

{ #category : #'initialize-release' }
SVGAttributes >> initialize [
	"Initialize a newly created instance. This method must answer the receiver."

	super initialize.
	" *** Edit the following to properly initialize instance variables ***"
	strokeWidth := nil.
	fillRule := nil.
	" *** And replace this comment with additional initialization code *** "
	^self
]

{ #category : #accessing }
SVGAttributes >> lineHeight [

	^lineHeight
]

{ #category : #accessing }
SVGAttributes >> lineHeight: anObject [

	lineHeight := anObject
]

{ #category : #operations }
SVGAttributes >> mergeWith: someAttributes [

	self class instVarNames do: 
			[:aName |
			(self perform: aName asSymbol) isNil
				ifTrue: 
					[self perform: (aName , ':') asSymbol
						with: (someAttributes perform: aName asSymbol)]]
]

{ #category : #accessing }
SVGAttributes >> noFill [

	^noFill ifNil: [false]
]

{ #category : #accessing }
SVGAttributes >> noFill: anObject [

	noFill := anObject
]

{ #category : #accessing }
SVGAttributes >> stroke [

	^stroke
]

{ #category : #accessing }
SVGAttributes >> stroke: anObject [

	| target |
	anObject = 'none' ifTrue: [^self strokeWidth: 0].
	anObject isString
		ifTrue: [target := self decodeColorAttribute: anObject]
		ifFalse: [target := anObject].
	stroke := target
]

{ #category : #accessing }
SVGAttributes >> strokeLineCap [

	^strokeLineCap
]

{ #category : #accessing }
SVGAttributes >> strokeLineCap: anObject [

	strokeLineCap := anObject
]

{ #category : #accessing }
SVGAttributes >> strokeLineJoin [

	^strokeLineJoin
]

{ #category : #accessing }
SVGAttributes >> strokeLineJoin: anObject [

	strokeLineJoin := anObject
]

{ #category : #accessing }
SVGAttributes >> strokeMiterlimit [

	^strokeMiterlimit
]

{ #category : #accessing }
SVGAttributes >> strokeMiterlimit: anObject [

	strokeMiterlimit := anObject
]

{ #category : #accessing }
SVGAttributes >> strokeOpacity [

	^strokeOpacity
]

{ #category : #accessing }
SVGAttributes >> strokeOpacity: anObject [

	strokeOpacity := anObject
]

{ #category : #accessing }
SVGAttributes >> strokeWidth [
	"https://www.w3.org/TR/2011/REC-SVG11-20110816/painting.html#StrokeProperty"

	^strokeWidth ifNil: [1]
]

{ #category : #accessing }
SVGAttributes >> strokeWidth: anObject [

	strokeWidth := anObject
]

{ #category : #accessing }
SVGAttributes >> width [

	^width
]

{ #category : #accessing }
SVGAttributes >> width: anObject [

	width := anObject isString ifTrue: [anObject asNumber] ifFalse: [anObject]
]

{ #category : #accessing }
SVGAttributes >> x [

	^x
]

{ #category : #accessing }
SVGAttributes >> x: anObject [

	x := anObject isString ifTrue: [anObject asNumber] ifFalse: [anObject]
]

{ #category : #accessing }
SVGAttributes >> y [

	^y
]

{ #category : #accessing }
SVGAttributes >> y: anObject [

	y := anObject isString ifTrue: [anObject asNumber] ifFalse: [anObject]
]
