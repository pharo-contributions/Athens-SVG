Class {
	#name : #ASNoFill,
	#superclass : #Object,
	#classInstVars : [
		'soleInstance'
	],
	#category : #'Athens-SVG-PathConverter'
}

{ #category : #'accessing' }
ASNoFill class >> soleInstance [

	^ soleInstance ifNil: [ soleInstance  := self new ]
	
]

{ #category : #'public' }
ASNoFill >> fill: aShape on: aCanvas [
	"do nothing"
]

{ #category : #'public' }
ASNoFill >> resolveIds: aDictionary [ 
	^ self
]

{ #category : #'public' }
ASNoFill >> stroke: aShape on: aCanvas [
	"do nothing" 

]
