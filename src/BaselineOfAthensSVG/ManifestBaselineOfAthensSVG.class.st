"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestBaselineOfAthensSVG,
	#superclass : #PackageManifest,
	#category : #'BaselineOfAthensSVG-Manifest'
}

{ #category : #'code-critics' }
ManifestBaselineOfAthensSVG class >> ruleClassNotReferencedRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGClassDefinition #(#BaselineOfAthensSVG)) #'2023-12-07T07:29:22.786191+01:00') )
]
