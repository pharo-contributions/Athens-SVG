"
Used for imaging operations performed via filter effects
"
Class {
	#name : #ASFilter,
	#superclass : #ASElement,
	#instVars : [
		'x',
		'y',
		'width',
		'height'
	],
	#category : #'Athens-SVG-Base'
}

{ #category : #filtering }
ASFilter >> color_interpolation_filters: aString [
	self attributeAt: #color_interpolation_filters put: aString
]

{ #category : #filtering }
ASFilter >> filterUnits: aString [
	self attributeAt: #filterUnits put: aString
]

{ #category : #accessing }
ASFilter >> height: aString [
	height := self translateLength: aString
]

{ #category : #filtering }
ASFilter >> primitiveUnits: aString [
	self attributeAt: #primitiveUnits put: aString
]

{ #category : #accessing }
ASFilter >> width: aString [
	width := self translateLength: aString
]

{ #category : #accessing }
ASFilter >> x: aString [
	x := self translateLength: aString
]

{ #category : #accessing }
ASFilter >> y: aString [
	y := self translateLength: aString
]
