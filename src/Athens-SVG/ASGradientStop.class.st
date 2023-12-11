"
Gradients are defined by a series of color stops in the gradient bar. A stop is the point at which a gradient changes from one color to the next, 
"
Class {
	#name : #ASGradientStop,
	#superclass : #ASElement,
	#instVars : [
		'color',
		'offset',
		'opacity'
	],
	#category : #'Athens-SVG-Base'
}

{ #category : #converting }
ASGradientStop >> asRampColorWithOpacity: aFloat [

		color ifNil: [ color := Color white ].

		^ Association key: offset value: (color alpha: self opacity * aFloat)
]

{ #category : #accessing }
ASGradientStop >> offset [
	^ offset
]

{ #category : #accessing }
ASGradientStop >> offset: aString [
	offset := self translateNumber: aString
]

{ #category : #accessing }
ASGradientStop >> opacity [
	^ opacity ifNil: [1]
]

{ #category : #accessing }
ASGradientStop >> setOpacity: number [

	color := color alpha: number
]

{ #category : #accessing }
ASGradientStop >> stop_color: aString [

	color := self translateColor: aString
]

{ #category : #accessing }
ASGradientStop >> stop_opacity: aString [

	opacity := self translateNumber: aString
]
