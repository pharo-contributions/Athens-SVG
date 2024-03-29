"
Abstract superclass for an SVG shape
"
Class {
	#name : #ASShape,
	#superclass : #ASElement,
	#category : #'Athens-SVG-Base'
}

{ #category : #testing }
ASShape class >> isAbstract [

	^ self == ASShape
]

{ #category : #rendering }
ASShape >> renderShapeOn: aCanvas [

"	(self id ='path3070-4' ) ifTrue: [ self halt ]."

	self display = 'none' ifTrue: [ ^ self ].

	self setShapeOn: aCanvas.
	self fill fill: self on: aCanvas.
	self stroke stroke: self on: aCanvas
]

{ #category : #'private - rendering' }
ASShape >> setShapeOn: aCanvas [
	self subclassResponsibility
]
