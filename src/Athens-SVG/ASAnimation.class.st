"
An animation in SVG
"
Class {
	#name : #ASAnimation,
	#superclass : #Object,
	#instVars : [
		'subject',
		'finishAction',
		'stepAction',
		'started',
		'stopCondition'
	],
	#category : #'Athens-SVG-Base'
}

{ #category : #accessing }
ASAnimation >> duration [

	^ Time millisecondClockValue - started
]

{ #category : #accessing }
ASAnimation >> finishAction [

	^ finishAction
]

{ #category : #accessing }
ASAnimation >> finishAction: anObject [

	finishAction := anObject
]

{ #category : #stepping }
ASAnimation >> start [

	started := Time millisecondClockValue
]

{ #category : #stepping }
ASAnimation >> step [

	(stopCondition value: self )
		ifTrue: [ finishAction value: self ]
		ifFalse: [ stepAction value: self  ]
]

{ #category : #accessing }
ASAnimation >> stepAction [

	^ stepAction
]

{ #category : #accessing }
ASAnimation >> stepAction: aBlock [

	stepAction := aBlock
]

{ #category : #accessing }
ASAnimation >> stopCondition: aBlock [

	stopCondition := aBlock
]

{ #category : #accessing }
ASAnimation >> subject [

	^ subject
]

{ #category : #accessing }
ASAnimation >> subject: anObject [

	subject := anObject
]
