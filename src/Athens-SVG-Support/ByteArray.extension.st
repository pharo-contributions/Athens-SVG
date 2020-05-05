Extension { #name : #ByteArray }

{ #category : #'*Athens-SVG-Support' }
ByteArray class >> fromHexString: aString [

	"(ByteArray fromHexString: 'A00B0210FF00') >>>  #[160 11 2 16 255 0]"

	| lookupTable result readStream |
	lookupTable := #(0 1 2 3 4 5 6 7 8 9 "numbers"
						nil nil nil nil nil nil nil 
						10 11 12 13 14 15  "uppercase"
						nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil 
						10 11 12 13 14 15  "lowercase"
						nil).
	result := self new: aString size // 2.
	readStream := aString readStream.
	1 to: result size do: [ :i |
		result at: i put: ((
			(lookupTable at: (readStream next asInteger - 47)) bitShift: 4) 
			bitOr: (lookupTable at: (readStream next asInteger - 47))) ].
	^result
]
