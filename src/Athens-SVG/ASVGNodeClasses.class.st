"
Gives easy access to the different SVG node classes from an XML node
"
Class {
	#name : #ASVGNodeClasses,
	#superclass : #Object,
	#category : #'Athens-SVG-Base'
}

{ #category : #factory }
ASVGNodeClasses class >> fromName: aNodeName [
	(self canUnderstand: aNodeName asSymbol) ifTrue: [ ^ self new perform: aNodeName asSymbol ]
	ifFalse: [ ^ ASMetadata ]
]

{ #category : #factory }
ASVGNodeClasses >> circle [
	^ ASCircle
]

{ #category : #factory }
ASVGNodeClasses >> defs [
	^ ASDefs
]

{ #category : #factory }
ASVGNodeClasses >> desc [
	^ ASMetadata
]

{ #category : #factory }
ASVGNodeClasses >> ellipse [
	^ ASEllipse
]

{ #category : #factory }
ASVGNodeClasses >> filter [
	^ ASFilter
]

{ #category : #factory }
ASVGNodeClasses >> g [
	^ ASGroupElement
]

{ #category : #factory }
ASVGNodeClasses >> line [
	^ ASLine
]

{ #category : #factory }
ASVGNodeClasses >> linearGradient [
	^ ASLinearGradient
]

{ #category : #factory }
ASVGNodeClasses >> metadata [
	^ ASMetadata
]

{ #category : #factory }
ASVGNodeClasses >> path [
	^ ASPath
]

{ #category : #factory }
ASVGNodeClasses >> polygon [
	^ ASPolygon
]

{ #category : #factory }
ASVGNodeClasses >> polyline [
	^ ASPolyLine
]

{ #category : #factory }
ASVGNodeClasses >> radialGradient [
	^ ASRadialGradient
]

{ #category : #factory }
ASVGNodeClasses >> rect [
	^ ASRect
]

{ #category : #factory }
ASVGNodeClasses >> stop [

	^ ASGradientStop
]

{ #category : #factory }
ASVGNodeClasses >> style [
	^ ASStyle
]

{ #category : #factory }
ASVGNodeClasses >> text [
	^ ASText
]
