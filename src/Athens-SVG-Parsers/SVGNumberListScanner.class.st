Class {
	#name : #SVGNumberListScanner,
	#superclass : #SmaCCScanner,
	#category : #'Athens-SVG-Parsers-SmaCC Generated Scanner'
}

{ #category : #generated }
SVGNumberListScanner class >> states [
	^ #(#default)
]

{ #category : #'VisualWorks metadata' }
SVGNumberListScanner class >> visualWorksMetadata [

	^ #(
		'namespace' 'SVGViewer'
		'superclassNamespace' 'Refactory.SmaCC'
	)
]

{ #category : #generated }
SVGNumberListScanner >> emptySymbolTokenId [
	^ 9
]

{ #category : #generated }
SVGNumberListScanner >> errorTokenId [
	^ 10
]

{ #category : #'initialize-release' }
SVGNumberListScanner >> initialize [
	"Initialize a newly created instance. This method must answer the receiver."

	super initialize.
	" *** Replace this comment with the appropriate initialization code *** "
	^self
]

{ #category : #generated }
SVGNumberListScanner >> scan1 [
	self step.
	(currentCharacter between: $0 and: $9)
		ifTrue: [ ^ self scan2 ].
	^ self reportLastMatch
]

{ #category : #generated }
SVGNumberListScanner >> scan2 [
	[ self recordMatch: #(3).
	self step.
	currentCharacter between: $0 and: $9 ] whileTrue.
	('Ee' includes: currentCharacter)
		ifTrue: [ ^ self scan3 ].
	^ self reportLastMatch
]

{ #category : #generated }
SVGNumberListScanner >> scan3 [
	self step.
	(currentCharacter between: $0 and: $9)
		ifTrue: [ [ self recordMatch: #(3).
			self step.
			currentCharacter between: $0 and: $9 ] whileTrue.
			^ self reportLastMatch ].
	('+-' includes: currentCharacter)
		ifTrue: [ self step.
			(currentCharacter between: $0 and: $9)
				ifTrue: [ [ self recordMatch: #(3).
					self step.
					currentCharacter between: $0 and: $9 ] whileTrue ] ].
	^ self reportLastMatch
]

{ #category : #generated }
SVGNumberListScanner >> scan4 [
	[ self recordMatch: #(3).
	self step.
	currentCharacter == $.
		ifTrue: [ ^ self scan2 ].
	currentCharacter between: $0 and: $9 ] whileTrue.
	('Ee' includes: currentCharacter)
		ifTrue: [ ^ self scan3 ].
	^ self reportLastMatch
]

{ #category : #generated }
SVGNumberListScanner >> scanForToken [
	self step.
	currentCharacter == $,
		ifTrue: [ ^ self recordAndReportMatch: #(1) ].
	currentCharacter == $-
		ifTrue: [ self step.
			currentCharacter == $.
				ifTrue: [ ^ self scan1 ].
			(currentCharacter between: $0 and: $9)
				ifTrue: [ ^ self scan4 ].
			^ self reportLastMatch ].
	currentCharacter == $.
		ifTrue: [ ^ self scan1 ].
	(currentCharacter between: $0 and: $9)
		ifTrue: [ ^ self scan4 ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ])
		ifTrue: [ [ self recordMatch: #(2).
			self step.
			currentCharacter isSeparator
				or: [ currentCharacter == Character pageUp ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
SVGNumberListScanner >> tokenActions [
	^ #(nil #whitespace)
]
