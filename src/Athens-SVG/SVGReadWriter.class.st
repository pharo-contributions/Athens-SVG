"
I am SVGReadWriter.
I am a concrete subclass of ImageReadWriter.

I implement the SVG image format.

  https://dev.w3.org/SVG/profiles/2.0/publish/single-page.html

NOTE: I only implement reading, not writing.  Creating SVG from raster formats is not very efficient.

I am a subclass of ImageReadWriter that understands SVG file streams, and can decode SVG images.
This code is based upon the Independent Joint Photographic Experts Group (IJPEG) software, originally written in C by Tom Lane, Philip Gladstone, Luis Ortiz, Jim Boucher, Lee Crocker, Julian Minguillon, George Phillips, Davide Rossi, Ge' Weijers, and other members of the Independent JPEG Group.


"
Class {
	#name : #SVGReadWriter,
	#superclass : #ImageReadWriter,
	#category : #'Athens-SVG'
}

{ #category : #'image reading/writing' }
SVGReadWriter class >> typicalFileExtensions [
	"Answer a collection of file extensions (lowercase) which files that I can read might commonly have"
	^#('svg')
]

{ #category : #accessing }
SVGReadWriter >> nextImage [
	| doc svg morph |
	doc := XMLDOMParser parse: stream.
	svg := AthensSVGConverter new importXMLDocument: doc.
	morph := ASVGMorph new svg: svg.
	^morph asForm
]

{ #category : #accessing }
SVGReadWriter >> nextPutImage: imageForm [
	self error: 'Cannot convert bitmapped image to vector format.'
]

{ #category : #accessing }
SVGReadWriter >> understandsImageFormat [ 
	| str |
	stream upTo: $<.
	"Skip processing directives etc..."
	[stream peek isLetter] whileFalse: [ stream upTo: $< ].
	str := (stream next: 3) asString.
	"Does the first element start with svg?"
	^str = 'svg'
]
