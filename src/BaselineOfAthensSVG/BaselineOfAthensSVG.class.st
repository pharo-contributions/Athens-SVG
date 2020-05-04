Class {
	#name : #BaselineOfAthensSVG,
	#superclass : #BaselineOf,
	#category : #BaselineOfAthensSVG
}

{ #category : #baselines }
BaselineOfAthensSVG >> baseline: spec [
	<baseline>

	spec for: #common do: [
		spec package: 'Athens-SVG'
	].		
]
