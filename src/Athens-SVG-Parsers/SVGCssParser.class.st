Class {
	#name : #SVGCssParser,
	#superclass : #SmaCCParser,
	#instVars : [
		'cssClasses',
		'cssClass'
	],
	#category : #'Athens-SVG-Parsers-SmaCC Generated Scanner Parser'
}

{ #category : #'generated-accessing' }
SVGCssParser class >> cacheId [
	^'2019-06-17T10:24:19.080588+02:00'
]

{ #category : #generated }
SVGCssParser class >> definitionComment [
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
<ident> : [A-Za-z] ([A-Za-z0-9]) +;

Css : ""["" ClassListOrNil ""]"";
ClassListOrNil : | ClassList;

ClassList: Class | Class ClassList;
Class : StartClass  StyleListOrNil ""}"" ;
StartClass : ""."" <ident> 'i' ""{"" {self startClass: i value};

StyleListOrNil: | StyleList;
StyleList : Style | Style "";""  StyleListOrNil;

Style : Fill | Stroke | StrokeLineCap | StrokeLineJoin | StrokeWidth | StrokeDashArray | StrokeMiterLimit | FillOpacity | FillRule | AnyRule;

Fill : <fill>  <valeur> 'v' {self attributes fill: (self colorAttribute: v)};
Stroke : <stroke>  <valeur> 'v' {self attributes stroke: (self colorAttribute: v)};
StrokeLineCap : <strokeLineCap>  <valeur> 'v' {self attributes strokeLineCap: (self identifierAttribute: v)};
StrokeLineJoin : <strokeLineJoin> <valeur> 'v' {self attributes strokeLineJoin: (self identifierAttribute: v)};
StrokeWidth : <strokeWidth>  <valeur> 'v' {self attributes strokeWidth: (self numberAttribute: v)};
StrokeDashArray : <strokeDashArray> <valeur>;
StrokeMiterLimit : <strokeMiterLimit> <valeur>;
FillOpacity : <fillOpacity> <valeur> 'v' {self attributes fillOpacity: (self numberAttribute: v)};
FillRule: <fillRule> <valeur>;
AnyRule : <ident>'i' <valeur> { self ignore: i value};"
]

{ #category : #'generated-accessing' }
SVGCssParser class >> scannerClass [
	^SVGCssScanner
]

{ #category : #generated }
SVGCssParser class >> startingStateForCss [
	^ 1
]

{ #category : #'VisualWorks metadata' }
SVGCssParser class >> visualWorksMetadata [

	^ #(
		'namespace' 'SVGViewer'
		'superclassNamespace' 'Refactory.SmaCC'
	)
]

{ #category : #accessing }
SVGCssParser >> attributes [


	^self cssClass attributes
]

{ #category : #accessing }
SVGCssParser >> attributes: anObject [

	self cssClass attributes: anObject
]

{ #category : #extracting }
SVGCssParser >> colorAttribute3: aString [

	| theRed theGreen theBlue |
	theRed := (ByteArray fromHexString: (String with: aString first) , (String with: aString first))
				first / 255.0.
	theGreen := (ByteArray fromHexString:(String with: aString second) , (String with: aString second))
				first / 255.0.
	theBlue := (ByteArray fromHexString:(String with: aString third) , (String with: aString third))
				first / 255.0.
	^(Color r: theRed g: theGreen b: theBlue)
]

{ #category : #extracting }
SVGCssParser >> colorAttribute: aNode [

	| aString anArray |
	aString := aNode value copyFrom: 2 to: aNode value size.
	aString = 'none' ifTrue: [
		^Color transparent].
	aString := (aString copyFrom: 2 to: aString size) asUppercase.
	aString size = 3 ifTrue: [^self colorAttribute3: aString].
	anArray := ByteArray fromHexString: aString.
	^Color
		r: anArray first / 255.0
		g: anArray second / 255.0
		b: anArray third / 255.0
]

{ #category : #accessing }
SVGCssParser >> cssClass [

	^cssClass
]

{ #category : #accessing }
SVGCssParser >> cssClasses [

	^cssClasses ifNil: [cssClasses := Dictionary new]
]

{ #category : #accessing }
SVGCssParser >> cssClasses: anObject [

	^cssClasses := anObject
]

{ #category : #extracting }
SVGCssParser >> identifierAttribute: aNode [

	| aString |
	aString := aNode value.
	^aString copyFrom: 2 to: aString size
]

{ #category : #operations }
SVGCssParser >> ignore: aString [
	Transcript show: 'Style attribute ignored :', aString;cr
]

{ #category : #'initialize-release' }
SVGCssParser >> initialize [
	"Initialize a newly created instance. This method must answer the receiver."

	super initialize.
	" *** Replace this comment with the appropriate initialization code *** "
	^self
]

{ #category : #extracting }
SVGCssParser >> numberAttribute: aNode [

	| aString |
	aString := aNode value.
	^(aString copyFrom: 2 to: aString size) asNumber
]

{ #category : #'generated-reduction actions' }
SVGCssParser >> reduceActionForAnyRule1: nodes [
	^ self ignore: (nodes at: 1) value
]

{ #category : #'generated-reduction actions' }
SVGCssParser >> reduceActionForFill1: nodes [
	^ self attributes fill: (self colorAttribute: (nodes at: 2))
]

{ #category : #'generated-reduction actions' }
SVGCssParser >> reduceActionForFillOpacity1: nodes [
	^ self attributes fillOpacity: (self numberAttribute: (nodes at: 2))
]

{ #category : #'generated-reduction actions' }
SVGCssParser >> reduceActionForStartClass1: nodes [
	^ self startClass: (nodes at: 2) value
]

{ #category : #'generated-reduction actions' }
SVGCssParser >> reduceActionForStroke1: nodes [
	^ self attributes stroke: (self colorAttribute: (nodes at: 2))
]

{ #category : #'generated-reduction actions' }
SVGCssParser >> reduceActionForStrokeLineCap1: nodes [
	^ self attributes
		strokeLineCap: (self identifierAttribute: (nodes at: 2))
]

{ #category : #'generated-reduction actions' }
SVGCssParser >> reduceActionForStrokeLineJoin1: nodes [
	^ self attributes
		strokeLineJoin: (self identifierAttribute: (nodes at: 2))
]

{ #category : #'generated-reduction actions' }
SVGCssParser >> reduceActionForStrokeWidth1: nodes [
	^ self attributes strokeWidth: (self numberAttribute: (nodes at: 2))
]

{ #category : #generated }
SVGCssParser >> reduceTable [
^#(
	#(20 0 #reduceFor:)
	#(30 0 #reduceFor:)
	#(33 1 #reduceFor:)
	#(20 1 #reduceFor:)
	#(36 3 #reduceFor:)
	#(21 1 #reduceFor:)
	#(27 1 #reduceFor:)
	#(30 1 #reduceFor:)
	#(33 2 #reduceFor:)
	#(31 3 #reduceActionForStartClass1:)
	#(29 2 #reduceActionForFill1:)
	#(22 2 #reduceActionForStroke1:)
	#(19 2 #reduceActionForStrokeLineCap1:)
	#(35 2 #reduceActionForStrokeWidth1:)
	#(39 2 #reduceActionForStrokeLineJoin1:)
	#(28 2 #reduceFor:)
	#(23 2 #reduceFor:)
	#(24 2 #reduceActionForFillOpacity1:)
	#(25 2 #reduceFor:)
	#(26 2 #reduceActionForAnyRule1:)
	#(32 3 #reduceFor:)
	#(27 3 #reduceFor:)
	)
]

{ #category : #operations }
SVGCssParser >> startClass: aString [

	cssClass := CssClass new.
	self cssClasses at: aString put: cssClass.
	cssClass identifier: aString.
	^cssClass
]

{ #category : #generated }
SVGCssParser >> symbolNames [
	^ #('"["' '"]"' '"}"' '";"' '"{"' '"."' '<whitespace>' '<fill>' '<stroke>' '<strokeLineCap>' '<strokeWidth>' '<strokeLineJoin>' '<strokeDashArray>' '<strokeMiterLimit>' '<fillOpacity>' '<fillRule>' '<valeur>' '<ident>' 'StrokeLineCap' 'ClassListOrNil' 'Style' 'Stroke' 'StrokeMiterLimit' 'FillOpacity' 'FillRule' 'AnyRule' 'StyleList' 'StrokeDashArray' 'Fill' 'StyleListOrNil' 'StartClass' 'Class' 'ClassList' 'B e g i n' 'StrokeWidth' 'Css' 'E O F' 'error' 'StrokeLineJoin')
]

{ #category : #generated }
SVGCssParser >> transitionTable [
^#(
#[1 0 9 0 1 0 13 0 36]
#[1 0 6 0 2 0 17 0 6 0 21 0 20 0 25 0 31 0 29 0 32 0 33 0 33]
#[0 0 0 0 37]
#[0 0 37 0 18]
#[0 0 41 0 2]
#[1 0 10 0 3 0 45 0 8 0 49 0 9 0 53 0 10 0 57 0 11 0 61 0 12 0 65 0 13 0 69 0 14 0 73 0 15 0 77 0 16 0 81 0 18 0 85 0 19 0 89 0 21 0 93 0 22 0 97 0 23 0 101 0 24 0 105 0 25 0 109 0 26 0 113 0 27 0 117 0 28 0 121 0 29 0 125 0 30 0 129 0 35 0 133 0 39]
#[1 0 14 0 2 0 17 0 6 0 25 0 31 0 29 0 32 0 137 0 33]
#[0 0 18 0 2]
#[0 0 141 0 5]
#[0 0 22 0 37]
#[0 0 145 0 17]
#[0 0 149 0 17]
#[0 0 153 0 17]
#[0 0 157 0 17]
#[0 0 161 0 17]
#[0 0 165 0 17]
#[0 0 169 0 17]
#[0 0 173 0 17]
#[0 0 177 0 17]
#[0 0 181 0 17]
#[0 0 26 0 3 0 4]
#[1 0 30 0 3 0 185 0 4]
#[0 0 26 0 3 0 4]
#[0 0 26 0 3 0 4]
#[0 0 26 0 3 0 4]
#[0 0 26 0 3 0 4]
#[0 0 26 0 3 0 4]
#[0 0 34 0 3]
#[0 0 26 0 3 0 4]
#[0 0 26 0 3 0 4]
#[0 0 189 0 3]
#[0 0 26 0 3 0 4]
#[0 0 26 0 3 0 4]
#[0 0 38 0 2]
#[0 0 42 0 3 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18]
#[0 0 46 0 3 0 4]
#[0 0 50 0 3 0 4]
#[0 0 54 0 3 0 4]
#[0 0 58 0 3 0 4]
#[0 0 62 0 3 0 4]
#[0 0 66 0 3 0 4]
#[0 0 70 0 3 0 4]
#[0 0 74 0 3 0 4]
#[0 0 78 0 3 0 4]
#[0 0 82 0 3 0 4]
#[1 0 10 0 3 0 45 0 8 0 49 0 9 0 53 0 10 0 57 0 11 0 61 0 12 0 65 0 13 0 69 0 14 0 73 0 15 0 77 0 16 0 81 0 18 0 85 0 19 0 89 0 21 0 93 0 22 0 97 0 23 0 101 0 24 0 105 0 25 0 109 0 26 0 113 0 27 0 117 0 28 0 121 0 29 0 193 0 30 0 129 0 35 0 133 0 39]
#[0 0 86 0 2 0 6]
#[0 0 90 0 3]
	)
]
