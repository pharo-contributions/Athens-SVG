"
A morph to zoom an SVG
"
Class {
	#name : #ASZoomerMorph,
	#superclass : #Morph,
	#instVars : [
		'basicExtent',
		'maxZoom',
		'currentAnimation',
		'currentZoom',
		'targetZoom',
		'animStartZoom',
		'svg',
		'surface',
		'svgExtent',
		'svgZoom',
		'animCenter'
	],
	#category : #'Athens-SVG-Morphic'
}

{ #category : #accessing }
ASZoomerMorph >> animateZoomTo: zoomLevel [


	targetZoom := zoomLevel.
	animStartZoom := currentZoom.

	currentAnimation := ASAnimation new subject: self.
	currentAnimation stopCondition: [:anim | anim duration >= self maxAnimationDuration ].
	currentAnimation stepAction:  [:anim | | duration |
		duration := (anim duration min: self maxAnimationDuration) / self maxAnimationDuration asFloat.

		self setZoom:  animStartZoom * (1-duration) + (targetZoom * duration).

		 ].
	currentAnimation finishAction: [:anim |
		self stopStepping.
		self setZoom: targetZoom.
		currentAnimation := nil.
		].

	currentAnimation start.
	self startStepping
]

{ #category : #drawing }
ASZoomerMorph >> drawDropShadowOn: aCanvas [
]

{ #category : #drawing }
ASZoomerMorph >> drawOn: aCanvas [

	svg ifNotNil: [

		surface drawDuring: [:canvas |

			surface clear.
			canvas pathTransform restoreAfter: [
				canvas pathTransform scaleBy: (currentZoom * svgZoom) asFloat.
				svg renderOn: canvas.
			]
		 ].
		aCanvas translucentImage: surface asForm at: self innerBounds origin

	] ifNil: [
		super drawOn: aCanvas.
	]
]

{ #category : #accessing }
ASZoomerMorph >> extent: pos [

	super extent: pos.

	animCenter := self bounds center
]

{ #category : #'event handling' }
ASZoomerMorph >> handlesDropShadowInHand [
	"Answer whether the receiver will handle drop shadow drawing when picked up in the hand."

	^ true
]

{ #category : #'event handling' }
ASZoomerMorph >> handlesMouseOver: evt [
	^ true
]

{ #category : #initialization }
ASZoomerMorph >> initialize [


	super initialize.

	currentZoom := 1.
	basicExtent  := self extent
]

{ #category : #'dropping/grabbing' }
ASZoomerMorph >> justDroppedInto: aMorph event: anEvent [

	super justDroppedInto: aMorph event: anEvent.

	animCenter := self bounds center
]

{ #category : #accessing }
ASZoomerMorph >> maxAnimationDuration [
	^ 100
]

{ #category : #accessing }
ASZoomerMorph >> maxZoom [

	^ maxZoom ifNil: [ maxZoom := 2 ]
]

{ #category : #accessing }
ASZoomerMorph >> maxZoom: aValue [

	maxZoom := aValue max: 1
]

{ #category : #'event handling' }
ASZoomerMorph >> mouseEnter: evt [
	self comeToFront.
	self animateZoomTo: self maxZoom
]

{ #category : #'event handling' }
ASZoomerMorph >> mouseLeave: evt [
	self animateZoomTo: 1
]

{ #category : #accessing }
ASZoomerMorph >> position: pos [

	super position: pos.

	animCenter := self bounds center
]

{ #category : #accessing }
ASZoomerMorph >> screenDPI [
	^ 96 "just a guess "
]

{ #category : #accessing }
ASZoomerMorph >> setZoom: aZoom [
	|  newExtent oldCenter |
	currentZoom := aZoom.
	newExtent := basicExtent * aZoom.

	oldCenter := animCenter.
	self bounds: (animCenter - (newExtent /2) extent: newExtent).
	animCenter := oldCenter.

	self changed
]

{ #category : #stepping }
ASZoomerMorph >> step [

	currentAnimation ifNotNil: [
		currentAnimation step
		]
]

{ #category : #stepping }
ASZoomerMorph >> stepTime [
	^ 20
]

{ #category : #accessing }
ASZoomerMorph >> svg: anSVG [

	^ self svg: anSVG zoom: 1
]

{ #category : #accessing }
ASZoomerMorph >> svg: anSVG zoom: anSvgZoom [
	| w h |

	svg := anSVG.
	svg isString ifTrue: [ svg :=  AthensSVGConverter fromFile: svg ].
	svgExtent := self extent.

	svg width ifNotNil: [
		w := svg width valueForDPI: self screenDPI.
		h := svg height valueForDPI: self screenDPI.
		svgExtent := (w@h) * anSvgZoom + (2@2).
		svgZoom := anSvgZoom.
	] ifNil: [
		svgExtent := self extent.
		svgZoom := 1.
	].

	surface := AthensCairoSurface extent: (svgExtent * self maxZoom + (1@1)) asIntegerPoint.
	basicExtent := svgExtent.
	self extent: svgExtent.
	currentZoom := 1.
	self changed
]

{ #category : #testing }
ASZoomerMorph >> wantsToBeDroppedInto: aMorph [

	^ aMorph isWorldMorph
]
