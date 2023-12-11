"
A color paint
"
Class {
	#name : #ASColorPaint,
	#superclass : #ASPaint,
	#instVars : [
		'color'
	],
	#category : #'Athens-SVG-Base'
}

{ #category : #accessing }
ASColorPaint >> color: aColor [
	color := aColor
]

{ #category : #accessing }
ASColorPaint >> fill: shape on: aCanvas [

	aCanvas setPaint: (color alpha: (color alpha * shape fill_opacity)).

	aCanvas draw
]

{ #category : #accessing }
ASColorPaint >> resolveIds: aDictionary [
	^ self
]

{ #category : #accessing }
ASColorPaint >> stroke: shape on: aCanvas [
	| stroke |
	stroke := aCanvas setStrokePaint: (color alpha: (color alpha * shape stroke_opacity)).

	stroke width: shape stroke_width.

	aCanvas draw
]
