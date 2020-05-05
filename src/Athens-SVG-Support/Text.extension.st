Extension { #name : #Text }

{ #category : #'*Athens-SVG-Support' }
Text >> isClassDeclNode [
	"Very very simple test for a css class declaration string."

	^(self text reject: #isSeparator) first == $.
]
