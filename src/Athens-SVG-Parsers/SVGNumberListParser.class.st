Class {
	#name : #SVGNumberListParser,
	#superclass : #SmaCCParser,
	#instVars : [
		'liste'
	],
	#category : #'Athens-SVG-Parsers-SmaCC Generated Parser'
}

{ #category : #'generated-accessing' }
SVGNumberListParser class >> cacheId [
	^'2019-06-17T10:21:25.375588+02:00'
]

{ #category : #generated }
SVGNumberListParser class >> definitionComment [
"<whitespace>
    : \s+
    ;
<exposant>
	: [eE] [\-\+]? [0-9]+
	;
<number>
	:
	0
	| (\-)? [1-9] [0-9]*
	| (\-)? [0-9]+ \. [0-9]* <exposant>?
	|  (\-)? \. [0-9]+ <exposant>?
	| (\-)? [0-9]+ <exposant>
	| (\-)? [0-9]+
	;

ListeOuNil : ListeVide | Liste;
ListeVide : ;
Liste : Number | Number CommaOuRien Liste;
Number : <number> 'x' { self liste add: x value asNumber};
CommaOuRien : | "","";"
]

{ #category : #'generated-accessing' }
SVGNumberListParser class >> scannerClass [
	^SVGNumberListScanner
]

{ #category : #generated }
SVGNumberListParser class >> startingStateForListeOuNil [
	^ 1
]

{ #category : #'VisualWorks metadata' }
SVGNumberListParser class >> visualWorksMetadata [

	^ #(
		'namespace' 'SVGViewer'
		'superclassNamespace' 'Refactory.SmaCC'
	)
]

{ #category : #'initialize-release' }
SVGNumberListParser >> initialize [
	"Initialize a newly created instance. This method must answer the receiver."

	super initialize.
	" *** Replace this comment with the appropriate initialization code *** "
	^self
]

{ #category : #accessing }
SVGNumberListParser >> liste [

	^liste ifNil: [liste := OrderedCollection new]
]

{ #category : #accessing }
SVGNumberListParser >> liste: anObject [

	liste := anObject
]

{ #category : #'generated-reduction actions' }
SVGNumberListParser >> reduceActionForNumber1: nodes [
	^ self liste add: (nodes at: 1) value asNumber
]

{ #category : #generated }
SVGNumberListParser >> reduceTable [
^#(
	#(6 0 #reduceFor:)
	#(11 1 #reduceActionForNumber1:)
	#(4 1 #reduceFor:)
	#(7 0 #reduceFor:)
	#(8 1 #reduceFor:)
	#(7 1 #reduceFor:)
	#(8 3 #reduceFor:)
	)
]

{ #category : #generated }
SVGNumberListParser >> symbolNames [
	^ #('","' '<whitespace>' '<number>' 'ListeOuNil' 'B e g i n' 'ListeVide' 'CommaOuRien' 'Liste' 'E O F' 'error' 'Number')
]

{ #category : #generated }
SVGNumberListParser >> transitionTable [
^#(
#[1 0 9 0 3 0 13 0 4 0 17 0 6 0 21 0 8 0 6 0 9 0 25 0 11]
#[0 0 10 0 1 0 3 0 9]
#[0 0 0 0 9]
#[0 0 14 0 9]
#[0 0 14 0 9]
#[1 0 29 0 1 0 18 0 3 0 33 0 7 0 22 0 9]
#[0 0 26 0 3]
#[1 0 9 0 3 0 37 0 8 0 25 0 11]
#[0 0 30 0 9]
	)
]
