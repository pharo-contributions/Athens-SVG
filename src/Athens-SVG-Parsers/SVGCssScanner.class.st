Class {
	#name : #SVGCssScanner,
	#superclass : #SmaCCScanner,
	#category : #'Athens-SVG-Parsers'
}

{ #category : #'generated-initialization' }
SVGCssScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(18 'fill' 8) #(18 'stroke' 9))
		do: [ :each |
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #generated }
SVGCssScanner class >> states [
	^ #(#default)
]

{ #category : #'VisualWorks metadata' }
SVGCssScanner class >> visualWorksMetadata [

	^ #(
		'namespace' 'SVGViewer'
		'superclassNamespace' 'Refactory.SmaCC'
	)
]

{ #category : #generated }
SVGCssScanner >> emptySymbolTokenId [
	^ 37
]

{ #category : #generated }
SVGCssScanner >> errorTokenId [
	^ 38
]

{ #category : #'initialize-release' }
SVGCssScanner >> initialize [
	"Initialize a newly created instance. This method must answer the receiver."

	super initialize.
	" *** Replace this comment with the appropriate initialization code *** "
	^self
]

{ #category : #generated }
SVGCssScanner >> scan1 [
	self step.
	currentCharacter == $t
		ifTrue: [ ^ self scan2 ].
	((currentCharacter between: $0 and: $9)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ (currentCharacter between: $a and: $s)
						or: [ currentCharacter between: $u and: $z ] ] ])
		ifTrue: [ [ self recordMatch: #(18).
			self step.
			(currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter between: $a and: $z ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
SVGCssScanner >> scan2 [
	self recordMatch: #(18).
	self step.
	currentCharacter == $r
		ifTrue: [ ^ self scan3 ].
	((currentCharacter between: $0 and: $9)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ (currentCharacter between: $a and: $q)
						or: [ currentCharacter between: $s and: $z ] ] ])
		ifTrue: [ [ self recordMatch: #(18).
			self step.
			(currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter between: $a and: $z ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
SVGCssScanner >> scan3 [
	self recordMatch: #(18).
	self step.
	currentCharacter == $o
		ifTrue: [ ^ self scan4 ].
	((currentCharacter between: $0 and: $9)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ (currentCharacter between: $a and: $n)
						or: [ currentCharacter between: $p and: $z ] ] ])
		ifTrue: [ [ self recordMatch: #(18).
			self step.
			(currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter between: $a and: $z ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
SVGCssScanner >> scan4 [
	self recordMatch: #(18).
	self step.
	currentCharacter == $k
		ifTrue:
			[ ^ self scan4X1 ].
	((currentCharacter between: $0 and: $9)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ (currentCharacter between: $a and: $j)
						or: [ currentCharacter between: $l and: $z ] ] ])
		ifTrue: [ [ self recordMatch: #(18).
			self step.
			(currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter between: $a and: $z ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
SVGCssScanner >> scan4X1 [
	self recordMatch: #(18).
	self step.
	currentCharacter == $e
		ifTrue:
			[ ^ self scan4X1X1 ].
	((currentCharacter between: $0 and: $9)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ (currentCharacter between: $a and: $d)
						or: [ currentCharacter between: $f and: $z ] ] ])
		ifTrue: [ [ self recordMatch: #(18).
			self step.
			(currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter between: $a and: $z ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
SVGCssScanner >> scan4X1X1 [
	self recordMatch: #(18).
	self step.
	currentCharacter == $-
		ifTrue:
			[ ^ self scan4X1X1X1 ].
	((currentCharacter between: $0 and: $9)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter between: $a and: $z ] ])
		ifTrue: [ [ self recordMatch: #(18).
			self step.
			(currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter between: $a and: $z ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
SVGCssScanner >> scan4X1X1X1 [
	self step.
	currentCharacter == $d
		ifTrue: [ (self scanForString: 'asharray')
				ifTrue: [ ^ self recordAndReportMatch: #(13) ].
			^ self reportLastMatch ].
	currentCharacter == $l
		ifTrue: [ (self scanForString: 'ine')
				ifTrue: [ self step.
					currentCharacter == $c
						ifTrue: [ (self scanForString: 'ap')
								ifTrue: [ ^ self recordAndReportMatch: #(10) ].
							^ self reportLastMatch ].
					currentCharacter == $j
						ifTrue: [ (self scanForString: 'oin')
								ifTrue: [ ^ self recordAndReportMatch: #(12) ] ] ].
			^ self reportLastMatch ].
	currentCharacter == $m
		ifTrue: [ (self scanForString: 'iterlimit')
				ifTrue: [ ^ self recordAndReportMatch: #(14) ].
			^ self reportLastMatch ].
	currentCharacter == $w
		ifTrue: [ (self scanForString: 'idth')
				ifTrue: [ ^ self recordAndReportMatch: #(11) ] ].
	^ self reportLastMatch
]

{ #category : #generated }
SVGCssScanner >> scanForToken [
	self step.
	currentCharacter == $.
		ifTrue: [ ^ self recordAndReportMatch: #(6) ].
	currentCharacter == $:
		ifTrue:
			[ ^ self scanForTokenX4 ].
	currentCharacter == $;
		ifTrue: [ ^ self recordAndReportMatch: #(4) ].
	currentCharacter == $[
		ifTrue: [ ^ self recordAndReportMatch: #(1) ].
	^ self scanForTokenX5
]

{ #category : #generated }
SVGCssScanner >> scanForTokenX1 [
	self step.
	currentCharacter == $i
		ifTrue: [ self recordMatch: #(18).
			(self scanForString: 'll')
				ifTrue: [ self recordMatch: #(18).
					self step.
					currentCharacter == $-
						ifTrue: [ self step.
							currentCharacter == $o
								ifTrue: [ (self scanForString: 'pacity')
										ifTrue: [ ^ self recordAndReportMatch: #(15) ].
									^ self reportLastMatch ].
							currentCharacter == $r
								ifTrue: [ (self scanForString: 'ule')
										ifTrue: [ ^ self recordAndReportMatch: #(16) ] ].
							^ self reportLastMatch ].
					((currentCharacter between: $0 and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter between: $a and: $z ] ])
						ifTrue: [ [ self recordMatch: #(18).
							self step.
							(currentCharacter between: $0 and: $9)
								or: [ (currentCharacter between: $A and: $Z)
										or: [ currentCharacter between: $a and: $z ] ] ] whileTrue ].
					^ self reportLastMatch ].
			((currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ (currentCharacter between: $a and: $k)
								or: [ currentCharacter between: $m and: $z ] ] ])
				ifTrue: [ [ self recordMatch: #(18).
					self step.
					(currentCharacter between: $0 and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter between: $a and: $z ] ] ] whileTrue ].
			^ self reportLastMatch ].
	((currentCharacter between: $0 and: $9)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ (currentCharacter between: $a and: $h)
						or: [ currentCharacter between: $j and: $z ] ] ])
		ifTrue: [ [ self recordMatch: #(18).
			self step.
			(currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter between: $a and: $z ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
SVGCssScanner >> scanForTokenX2 [
	self step.
	((currentCharacter between: $0 and: $9)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter between: $a and: $z ] ])
		ifTrue: [ [ self recordMatch: #(18).
			self step.
			(currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter between: $a and: $z ] ] ] whileTrue ]
]

{ #category : #generated }
SVGCssScanner >> scanForTokenX3 [
	[ self recordMatch: #(7).
	self step.
	currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
SVGCssScanner >> scanForTokenX4 [
	self step.
	currentCharacter ~~ $;
		ifTrue: [ [ self recordMatch: #(17).
			self step.
			currentCharacter ~~ $; ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
SVGCssScanner >> scanForTokenX5 [
	currentCharacter == $]
		ifTrue: [ ^ self recordAndReportMatch: #(2) ].
	currentCharacter == $f
		ifTrue:
			[ ^ self scanForTokenX1 ].
	currentCharacter == $s
		ifTrue: [ ^ self scan1 ].
	currentCharacter == ${
		ifTrue: [ ^ self recordAndReportMatch: #(5) ].
	currentCharacter == $}
		ifTrue: [ ^ self recordAndReportMatch: #(3) ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ])
		ifTrue:
			[ ^ self scanForTokenX3 ].
	((currentCharacter between: $A and: $Z)
		or: [ (currentCharacter between: $a and: $e)
				or: [ (currentCharacter between: $g and: $r)
						or: [ currentCharacter between: $t and: $z ] ] ])
		ifTrue:
			[ self scanForTokenX2 ].
	^ self reportLastMatch
]

{ #category : #generated }
SVGCssScanner >> tokenActions [
	^ #(nil nil nil nil nil nil #whitespace)
]
