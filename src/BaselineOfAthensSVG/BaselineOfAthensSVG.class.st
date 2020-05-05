Class {
	#name : #BaselineOfAthensSVG,
	#superclass : #BaselineOf,
	#category : #BaselineOfAthensSVG
}

{ #category : #baselines }
BaselineOfAthensSVG >> baseline: spec [
	<baseline>

	spec for: #common do: [
		spec baseline: 'XMLParser' with: [
			spec repository: 'github://pharo-contributions/XML-XMLParser/src' ].

		spec package: 'Athens-SVG'
	].		
]
