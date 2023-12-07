Extension { #name : #CssClass }

{ #category : #'*Athens-SVG-Parsers' }
CssClass >> cssFromAttributes: aString [
	"The expected aString looks something like this:
		'{fill:#4d82b8}'
	So we have to get rid of the curly braces."

	| aParser |
	aParser := SVGStyleParser on:
		           (aString copyFrom: 2 to: aString size - 1) readStream.
	aParser parse.
	self attributes: aParser attributes
]
