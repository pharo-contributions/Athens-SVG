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

{ #category : #'as yet unclassified' }
ASGradientStop >> asRampColorWithOpacity: aFloat [

		color ifNil: [ color := Color white ].

		^ Association key: offset value: (color alpha: self opacity * aFloat)
]

{ #category : #'as yet unclassified' }
ASGradientStop >> offset [
	^ offset
]

{ #category : #'as yet unclassified' }
ASGradientStop >> offset: aString [
	offset := self translateNumber: aString
]

{ #category : #'as yet unclassified' }
ASGradientStop >> opacity [
	^ opacity ifNil: [1]
]

{ #category : #'as yet unclassified' }
ASGradientStop >> setOpacity: number [

	color := color alpha: number
]

{ #category : #'as yet unclassified' }
ASGradientStop >> stop_color: aString [

	color := self translateColor: aString
]

{ #category : #'as yet unclassified' }
ASGradientStop >> stop_opacity: aString [

	opacity := self translateNumber: aString
]
