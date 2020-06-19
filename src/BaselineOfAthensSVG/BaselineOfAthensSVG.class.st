Class {
	#name : #BaselineOfAthensSVG,
	#superclass : #BaselineOf,
	#category : #BaselineOfAthensSVG
}

{ #category : #baselines }
BaselineOfAthensSVG >> baseline: spec [
	<baseline>

	spec for: #common do: [

		spec package: 'Athens-SVG-PathConverter'.

		spec baseline: 'XMLParser' with: [
			spec repository: 'github://pharo-contributions/XML-XMLParser/src' ].
		spec baseline: 'SmaCC' with: [
			spec repository: 'github://SmaCCRefactoring/SmaCC'; loads: 'Runtime' ].

		spec package: 'Athens-SVG-Support'.
		spec package: 'Athens-SVG-Parsers'.
		spec package: 'Athens-SVG'.
		
		spec group: 'PathConverter' with: #('Athens-SVG-PathConverter').
		spec group: 'default' with: #('XMLParser' 'SmaCC' 'Athens-SVG-Support' 'Athens-SVG-Parsers' 'Athens-SVG').
	].		
]
