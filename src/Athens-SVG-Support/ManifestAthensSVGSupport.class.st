"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestAthensSVGSupport,
	#superclass : #PackageManifest,
	#category : #'Athens-SVG-Support-Manifest'
}

{ #category : #'code-critics' }
ManifestAthensSVGSupport class >> ruleExcessiveVariablesRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGClassDefinition #(#SVGAttributes)) #'2023-12-07T12:01:52.800001+01:00') )
]
