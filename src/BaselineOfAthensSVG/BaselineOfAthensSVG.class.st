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
		spec baseline: 'SmaCC' with: [
			spec repository: 'github://SmaCCRefactoring/SmaCC'; load: 'Runtime' ].

		spec package: 'Athens-SVG-Support'.
		spec package: 'Athens-SVG-Parsers'.
		spec package: 'Athens-SVG'
	].		
]
