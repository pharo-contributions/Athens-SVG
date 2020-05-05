Extension { #name : #XMLString }

{ #category : #'*Athens-SVG-Support' }
XMLString >> isClassDeclNode [
	"Very very simple test for a css class declaration string."

	^(self string reject: #isSeparator) first == $.
]
