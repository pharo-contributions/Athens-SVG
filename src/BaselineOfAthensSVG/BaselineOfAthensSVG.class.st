"
Baseline for Athens SVG support [https://github.com/pharo-contributions/Athens-SVG](https://github.com/pharo-contributions/Athens-SVG)
"
Class {
	#name : #BaselineOfAthensSVG,
	#superclass : #BaselineOf,
	#category : #'BaselineOfAthensSVG-Base'
}

{ #category : #baselines }
BaselineOfAthensSVG >> baseline: spec [
	<baseline>
	
	spec for: #common do: [
		"Dependencies"
		self 
			xmlParser: spec;
			smaccRuntime: spec.

		"Packages"		
		spec 
			package: 'Athens-SVG-PathConverter';
			package: 'Athens-SVG-Support' with: [ spec requires: 'XMLParser' ];
			package: 'Athens-SVG-Parsers' with: [ spec requires: #('SmaCC' 'Athens-SVG-Support') ];
			package: 'Athens-SVG' with: [ spec requires: #('Athens-SVG-PathConverter' 'Athens-SVG-Support') ];
			package: 'Athens-SVG-Tests' with: [ spec requires: 'Athens-SVG' ].

		"Groups (custom)"
		spec 
			group: 'PathConverter' with: #( 'Athens-SVG-PathConverter' );
			group: 'Support' with: #( 'Athens-SVG-Support' );
			group: 'Parsers' with: #( 'Athens-SVG-Parsers' );
			group: 'Core' with: #( 'Athens-SVG' );
			group: 'Tests' with: #( 'Athens-SVG-Tests' );
			group: 'CI' with: #( 'Tests' ).
		
		"Groups (standard)"
		spec
			group: 'all' with: #( 'PathConverter' 'Support' 'Parsers' 'Core' 'Tests');
			group: 'default' with: #( 'all' ) ]
]

{ #category : #dependencies }
BaselineOfAthensSVG >> smaccRuntime: spec [

	spec baseline: 'SmaCC' with: [
		spec
			repository: 'github://SmaCCRefactoring/SmaCC';
			loads: 'Runtime' ]
]

{ #category : #dependencies }
BaselineOfAthensSVG >> xmlParser: spec [

	spec
		baseline: 'XMLParser'
		with: [
		spec repository: 'github://pharo-contributions/XML-XMLParser/src' ]
]
