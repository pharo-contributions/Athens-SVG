"
Fill without any effect
"
Class {
	#name : #ASNoFill,
	#superclass : #Object,
	#classInstVars : [
		'soleInstance'
	],
	#category : #'Athens-SVG-PathConverter-Filling'
}

{ #category : #accessing }
ASNoFill class >> soleInstance [

	^ soleInstance ifNil: [ soleInstance  := self new ]
]

{ #category : #public }
ASNoFill >> fill: aShape on: aCanvas [
	"Do nothing"
]

{ #category : #public }
ASNoFill >> resolveIds: aDictionary [

	^ self
]

{ #category : #public }
ASNoFill >> stroke: aShape on: aCanvas [
	"Do nothing"
]
