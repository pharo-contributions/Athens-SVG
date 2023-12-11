"
SVG group element
"
Class {
	#name : #ASGroupElement,
	#superclass : #ASContainerElement,
	#instVars : [
		'stroke_opacity'
	],
	#category : #'Athens-SVG-Base'
}

{ #category : #attributes }
ASGroupElement >> stroke_opacity: aString [
	stroke_opacity := self translateNumber: aString
]
