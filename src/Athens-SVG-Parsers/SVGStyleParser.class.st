Class {
	#name : #SVGStyleParser,
	#superclass : #SmaCCParser,
	#instVars : [
		'attributes'
	],
	#category : #'Athens-SVG-Parsers-SmaCC Generated Scanner Parser'
}

{ #category : #generated }
SVGStyleParser class >> definitionComment [
"<whitespace>
    : \s+
    ;
<fill> : fill;
<stroke> : stroke;
<strokeLineWith>: stroke-line-width;
<strokeLineCap> : stroke-linecap;
<strokeWidth> : stroke-width;
<strokeLineJoin> : stroke-linejoin;
<strokeDashArray> : stroke-dasharray;
<strokeMiterLimit> : stroke-miterlimit;
<fillOpacity> : fill-opacity;
<fillRule> : fill-rule;
<enableBackground> : enable-background;
<valeur> : \:[^;]+;
<ident>: [\-A-Za-z] [A-Za-z0-9\-]+;


StyleListOrNil: | StyleList;

StyleList : Style | Style "";""  StyleListOrNil;

Style : Fill | Stroke | StrokeLineCap | StrokeLineJoin | StrokeWidth | StrokeDashArray | StrokeMiterLimit | FillOpacity | FillRule | EnableBackground |AnyRule;

Fill : <fill>  <valeur> 'v' {self attributes fill: (self colorAttribute: v)};
Stroke : <stroke>  <valeur> 'v' {self attributes stroke: (self colorAttribute: v)};
StrokeLineCap : <strokeLineCap>  <valeur> 'v' {self attributes strokeLineCap: (self identifierAttribute: v)};
StrokeLineJoin : <strokeLineJoin> <valeur> 'v' {self attributes strokeLineJoin: (self identifierAttribute: v)};
StrokeWidth : <strokeWidth>  <valeur> 'v' {self attributes strokeWidth: (self numberAttribute: v)};
StrokeDashArray : <strokeDashArray> <valeur>;
StrokeMiterLimit : <strokeMiterLimit> <valeur>;
FillOpacity : <fillOpacity> <valeur> 'v' {self attributes fillOpacity: (self numberAttribute: v)};
FillRule: <fillRule> <valeur>;
EnableBackground: <enableBackground> <valeur> 'v' {self enableBackground: v value};
AnyRule : <ident>'i' <valeur> { self ignore: i value};"
]

{ #category : #'generated-accessing' }
SVGStyleParser class >> scannerClass [
	^SVGStyleScanner
]

{ #category : #generated }
SVGStyleParser class >> startingStateForStyleListOrNil [

	^1
]

{ #category : #'VisualWorks metadata' }
SVGStyleParser class >> visualWorksMetadata [

	^ #(
		'namespace' 'SVGViewer'
		'superclassNamespace' 'Refactory.SmaCC'
	)
]

{ #category : #accessing }
SVGStyleParser >> attributes [

	^attributes ifNil: [attributes := SVGAttributes new]
]

{ #category : #accessing }
SVGStyleParser >> attributes: anObject [

	attributes := anObject
]

{ #category : #operations }
SVGStyleParser >> colorAttribute3: aString [

	| theRed theGreen theBlue |
	theRed := (ByteArray fromHexString: (String with: aString first) , (String with: aString first))
				first / 255.0.
	theGreen := (ByteArray fromHexString:(String with: aString second) , (String with: aString second))
				first / 255.0.
	theBlue := (ByteArray fromHexString:(String with: aString third) , (String with: aString third))
				first / 255.0.
	^(Color r: theRed g: theGreen b: theBlue)
]

{ #category : #operations }
SVGStyleParser >> colorAttribute: aNode [

	| aString anArray cl |
	aString := aNode value copyFrom: 2 to: aNode value size.
	aString := aString trimBoth.
	aString = 'none' ifTrue: [
		^ Color transparent].
	[cl := Color perform: aString asLowercase asSymbol]
		on: MessageNotUnderstood
		do: [:ex | ].
	cl ifNotNil: [^cl].
	aString := (aString copyFrom: 2 to: aString size) asUppercase.
	aString size = 3 ifTrue: [^self colorAttribute3: aString].
	anArray := ByteArray fromHexString: aString.
	^Color
		r: anArray first / 255.0
		g: anArray second / 255.0
		b: anArray third / 255.0
]

{ #category : #operations }
SVGStyleParser >> enableBackground: aString [

	| anArray |
	anArray := aString asArrayOfSubstringsSeparatedBy: Character space.
	anArray size >= 5 ifTrue: [(self attributes) x: anArray second asNumber;
					y: anArray third asNumber;
					width: anArray fourth asNumber;
					height:anArray fifth asNumber]
]

{ #category : #private }
SVGStyleParser >> identifierAttribute: aNode [

	| aString |
	aString := aNode value.
	^aString copyFrom: 2 to: aString size
]

{ #category : #operations }
SVGStyleParser >> ignore: aString [

	Transcript show: 'Style attribute ', aString , ' ignored';cr
]

{ #category : #'initialize-release' }
SVGStyleParser >> initialize [
	"Initialize a newly created instance. This method must answer the receiver."

	super initialize.
	" *** Replace this comment with the appropriate initialization code *** "
	^self
]

{ #category : #private }
SVGStyleParser >> numberAttribute: aNode [

	| aString |
	aString := aNode value.
	^(aString copyFrom: 2 to: aString size) asNumber
]

{ #category : #'generated-reduction actions' }
SVGStyleParser >> reduceActionForAnyRule1: nodes [

	^self ignore: (nodes at: 1) value
]

{ #category : #'generated-reduction actions' }
SVGStyleParser >> reduceActionForEnableBackground1: nodes [

	^self enableBackground: (nodes at: 2) value
]

{ #category : #'generated-reduction actions' }
SVGStyleParser >> reduceActionForFill1: nodes [

	^self attributes fill: (self colorAttribute: (nodes at: 2))
]

{ #category : #'generated-reduction actions' }
SVGStyleParser >> reduceActionForFillOpacity1: nodes [

	^self attributes fillOpacity: (self numberAttribute: (nodes at: 2))
]

{ #category : #'generated-reduction actions' }
SVGStyleParser >> reduceActionForStroke1: nodes [

	^self attributes stroke: (self colorAttribute: (nodes at: 2))
]

{ #category : #'generated-reduction actions' }
SVGStyleParser >> reduceActionForStrokeLineCap1: nodes [

	^self attributes strokeLineCap: (self identifierAttribute: (nodes at: 2))
]

{ #category : #'generated-reduction actions' }
SVGStyleParser >> reduceActionForStrokeLineJoin1: nodes [

	^self attributes strokeLineJoin: (self identifierAttribute: (nodes at: 2))
]

{ #category : #'generated-reduction actions' }
SVGStyleParser >> reduceActionForStrokeWidth1: nodes [

	^self attributes strokeWidth: (self numberAttribute: (nodes at: 2))
]

{ #category : #generated }
SVGStyleParser >> reduceTable [
^#(
	#(17 0 #reduceFor:)
	#(26 1 #reduceFor:)
	#(17 1 #reduceFor:)
	#(16 1 #reduceFor:)
	#(25 2 #reduceActionForFill1:)
	#(24 2 #reduceActionForStroke1:)
	#(23 2 #reduceActionForStrokeLineCap1:)
	#(21 2 #reduceActionForStrokeWidth1:)
	#(22 2 #reduceActionForStrokeLineJoin1:)
	#(20 2 #reduceFor:)
	#(19 2 #reduceFor:)
	#(18 2 #reduceActionForFillOpacity1:)
	#(15 2 #reduceFor:)
	#(28 2 #reduceActionForEnableBackground1:)
	#(31 2 #reduceActionForAnyRule1:)
	#(16 3 #reduceFor:)
	)
]

{ #category : #generated }
SVGStyleParser >> transitionTable [
^#(
#[1 0 9 0 3 0 13 0 4 0 17 0 5 0 21 0 6 0 25 0 7 0 29 0 8 0 33 0 9 0 37 0 10 0 41 0 11 0 45 0 12 0 49 0 14 0 53 0 15 0 57 0 16 0 61 0 17 0 65 0 18 0 69 0 19 0 73 0 20 0 77 0 21 0 81 0 22 0 85 0 23 0 89 0 24 0 93 0 25 0 97 0 26 0 101 0 28 0 6 0 29 0 105 0 31]
#[0 0 109 0 13]
#[0 0 113 0 13]
#[0 0 117 0 13]
#[0 0 121 0 13]
#[0 0 125 0 13]
#[0 0 129 0 13]
#[0 0 133 0 13]
#[0 0 137 0 13]
#[0 0 141 0 13]
#[0 0 145 0 13]
#[0 0 149 0 13]
#[0 0 10 0 1 0 29]
#[0 0 14 0 29]
#[0 0 0 0 29]
#[0 0 10 0 1 0 29]
#[0 0 10 0 1 0 29]
#[0 0 10 0 1 0 29]
#[0 0 10 0 1 0 29]
#[0 0 10 0 1 0 29]
#[0 0 10 0 1 0 29]
#[0 0 10 0 1 0 29]
#[0 0 10 0 1 0 29]
#[1 0 153 0 1 0 18 0 29]
#[0 0 10 0 1 0 29]
#[0 0 10 0 1 0 29]
#[0 0 22 0 1 0 29]
#[0 0 26 0 1 0 29]
#[0 0 30 0 1 0 29]
#[0 0 34 0 1 0 29]
#[0 0 38 0 1 0 29]
#[0 0 42 0 1 0 29]
#[0 0 46 0 1 0 29]
#[0 0 50 0 1 0 29]
#[0 0 54 0 1 0 29]
#[0 0 58 0 1 0 29]
#[0 0 62 0 1 0 29]
#[1 0 9 0 3 0 13 0 4 0 17 0 5 0 21 0 6 0 25 0 7 0 29 0 8 0 33 0 9 0 37 0 10 0 41 0 11 0 45 0 12 0 49 0 14 0 53 0 15 0 57 0 16 0 157 0 17 0 65 0 18 0 69 0 19 0 73 0 20 0 77 0 21 0 81 0 22 0 85 0 23 0 89 0 24 0 93 0 25 0 97 0 26 0 101 0 28 0 6 0 29 0 105 0 31]
#[0 0 66 0 29]
	)
]
