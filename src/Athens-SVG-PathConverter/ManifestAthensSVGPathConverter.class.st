"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestAthensSVGPathConverter,
	#superclass : #PackageManifest,
	#category : #'Athens-SVG-PathConverter-Manifest'
}

{ #category : #'code-critics' }
ManifestAthensSVGPathConverter class >> ruleBadMessageRule2V1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#ASPathConverter #convertPathData #false)) #'2023-12-07T12:26:47.564626+01:00') #(#(#RGMethodDefinition #(#ASPathConverter #lastBezierPoint #false)) #'2023-12-07T12:30:01.22886+01:00') )
]

{ #category : #'code-critics' }
ManifestAthensSVGPathConverter class >> ruleExcessiveArgumentsRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#ASPathConverter #ellipticalArc:xrot:large:sweep:to: #false)) #'2023-12-07T12:28:45.108721+01:00') #(#(#RGMethodDefinition #(#ASPathConverter #ellipticalArc:xrot:large:sweep:to:relative: #false)) #'2023-12-07T12:28:49.789932+01:00') )
]

{ #category : #'code-critics' }
ManifestAthensSVGPathConverter class >> ruleLiteralArrayCharactersRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#ASPathConverter #assertValidCommand: #false)) #'2023-12-07T12:24:35.176693+01:00') )
]

{ #category : #'code-critics' }
ManifestAthensSVGPathConverter class >> ruleLiteralArrayContainsSuspiciousTrueFalseOrNilRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMetaclassDefinition #(#'ManifestAthensSVGPathConverter class' #ManifestAthensSVGPathConverter)) #'2023-12-07T12:35:04.457227+01:00') )
]
