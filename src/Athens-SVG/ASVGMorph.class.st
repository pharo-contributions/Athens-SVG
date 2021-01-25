Class {
	#name : #ASVGMorph,
	#superclass : #Morph,
	#instVars : [
		'svg',
		'surface',
		'zoom',
		'session'
	],
	#category : #'Athens-SVG'
}

{ #category : #'file service' }
ASVGMorph class >> fileReaderServicesForFile: fullName suffix: suffix [
	<fileService>

	^ (#('svg') includes: suffix)
		ifTrue: [ self services]
		ifFalse: [#()]

]

{ #category : #'instance creation' }
ASVGMorph class >> fromFile: aFileName [
	| svg |
	svg := AthensSVGConverter fromFile: aFileName.
	^ self new svg: svg 
]

{ #category : #'file service' }
ASVGMorph class >> openImageAsMorph: fullName [ 
	
	| fileReference aMorph parser xmlDoc svgRoot |
	fileReference := fullName asFileReference.
	parser := XMLDOMParser on: (XMLDecodingReadStreamAdapter nonDecodingOn: fileReference binaryReadStream wrappedStream) documentURI: fileReference uri.
	xmlDoc := parser parseDocument.
	svgRoot :=  AthensSVGConverter new importXMLDocument: xmlDoc.

	aMorph := self new svg: svgRoot.
	aMorph openInWorld.
]

{ #category : #'file service' }
ASVGMorph class >> serviceOpenImageAsMorph [
	"Answer a service for opening a graphic in a window"

	^ SimpleServiceEntry 
		provider: self 
		label: 'Open graphic as a morph'
		selector: #openImageAsMorph:
		description: 'Open a graphic file as a moprh'
		buttonLabel: 'Open'
]

{ #category : #'file service' }
ASVGMorph class >> services [

	^ Array 
		with: self serviceOpenImageAsMorph

]

{ #category : #'session management' }
ASVGMorph >> checkSession [

	session == Smalltalk session ifFalse: [
		self initializeForNewSession	
	]
]

{ #category : #drawing }
ASVGMorph >> drawOn: aCanvas [

	self checkSession.

	surface drawDuring: [:canvas |  
		
		surface clear.
"		canvas setPaint: Color red;
		drawShape:  (0@0 corner: self extent).
"		canvas pathTransform restoreAfter: [
			canvas pathTransform scaleBy:zoom.
			svg renderOn: canvas viewportExtent: self extent.
		]
	 ].
	aCanvas translucentImage: surface asForm at: self innerBounds origin
]

{ #category : #initialize }
ASVGMorph >> initialize [
	super initialize. 
	zoom :=1.
]

{ #category : #'session management' }
ASVGMorph >> initializeForNewSession [	
	| w h |
	svg width ifNotNil: [
		w := svg width valueForDPI: self screenDPI.
		h := svg height valueForDPI: self screenDPI.
		] ifNil: [
		w := 500. h := 400.
		].
	surface := AthensCairoSurface extent: (w asInteger @ (h asInteger + 1)).
	
	self extent: surface extent.
	
	session := Smalltalk session.
	
	
]

{ #category : #accessing }
ASVGMorph >> screenDPI [ 
	^ 96 "just a guess "
]

{ #category : #accessing }
ASVGMorph >> setZoom: factor [

	| w h |
	w := svg width valueForDPI: self screenDPI.
	h := svg height valueForDPI: self screenDPI.
	zoom := factor.
	surface := AthensCairoSurface extent: (w*factor) asInteger @ ((h*factor) asInteger + 1).
	
	self extent: surface extent.
	self changed
]

{ #category : #accessing }
ASVGMorph >> svg: aSVGRoot [
	
	svg := aSVGRoot.
	
	self initializeForNewSession.
	
	self changed
]
