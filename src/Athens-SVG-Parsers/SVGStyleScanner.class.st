Class {
	#name : #SVGStyleScanner,
	#superclass : #SmaCCScanner,
	#category : #'Athens-SVG-Parsers-SmaCC Generated Scanner'
}

{ #category : #'generated-initialization' }
SVGStyleScanner class >> initializeKeywordMap [

	keywordMap := Dictionary new.
	#(#(14 'enable-background' 12) #(14 'fill' 3) #(14 'fill-opacity' 10) #(14 'fill-rule' 11) #(14 'stroke' 4) #(14 'stroke-dasharray' 8) #(14 'stroke-linecap' 5) #(14 'stroke-linejoin' 7) #(14 'stroke-miterlimit' 9) #(14 'stroke-width' 6))
		do:
			[:each |
			(keywordMap at: each first ifAbsentPut: [Dictionary new]) at: (each at: 2)
				put: each last].
	^keywordMap
]

{ #category : #generated }
SVGStyleScanner >> emptySymbolTokenId [

	^29
]

{ #category : #generated }
SVGStyleScanner >> errorTokenId [

	^30
]

{ #category : #'initialize-release' }
SVGStyleScanner >> initialize [
	"Initialize a newly created instance. This method must answer the receiver."

	super initialize.
	" *** Replace this comment with the appropriate initialization code *** "
	^self
]

{ #category : #generated }
SVGStyleScanner >> scanForToken [

	self step.
	currentCharacter == $; ifTrue: [^self recordAndReportMatch: #(1)].
	currentCharacter == $:
		ifTrue:
			[self step.
			currentCharacter ~~ $;
				ifTrue:
					[
					[self recordMatch: #(13).
					self step.
					currentCharacter ~~ $;]
							whileTrue].
			^self reportLastMatch].
	(currentCharacter isBlank
		or: [currentCharacter between: Character lf and: Character cr])
			ifTrue:
				[
				[self recordMatch: #(2).
				self step.
				currentCharacter isBlank
					or: [currentCharacter between: Character lf and: Character cr]]
						whileTrue.
				^self reportLastMatch].
	(currentCharacter isLetter or: [currentCharacter == $-])
		ifTrue:
			[self step.
			(currentCharacter isAlphaNumeric or: [currentCharacter == $-])
				ifTrue:
					[
					[self recordMatch: #(14).
					self step.
					currentCharacter isAlphaNumeric or: [currentCharacter == $-]]
							whileTrue]].
	^self reportLastMatch
]

{ #category : #generated }
SVGStyleScanner >> tokenActions [

	^#(nil #whitespace)
]
