Extension { #name : #Character }

{ #category : #'*Athens-SVG-Support' }
Character >> isBlank [
	"space or tab"
	^self == ($ ) or: [ self == ($	) ]
]
