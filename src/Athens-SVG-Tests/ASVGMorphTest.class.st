"
An ASVGMorphTest is a test class for testing the behavior of ASVGMorph
"
Class {
	#name : #ASVGMorphTest,
	#superclass : #TestCase,
	#category : #'Athens-SVG-Tests'
}

{ #category : #tests }
ASVGMorphTest class >> iconSVGFileContent [

	^'<?xml version="1.0" standalone="no"?>
<svg xmlns="http://www.w3.org/2000/svg" class="icon" viewBox="0 0 1024 1024">
  <path d="M854.6 288.7c6 6 9.4 14.1 9.4 22.6V928c0 17.7-14.3 32-32 32H192c-17.7 0-32-14.3-32-32V96c0-17.7 14.3-32 32-32h424.7c8.5 0 16.7 3.4 22.7 9.4l215.2 215.3zM790.2 326L602 137.8V326h188.2z"/>
</svg>'

	


]

{ #category : #tests }
ASVGMorphTest class >> inkscapeSVGFileContent [

	^'<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!-- Created with Inkscape (http://www.inkscape.org/) -->

<svg
   width="300"
   height="100.00001"
   viewBox="0 0 79.374998 26.458335"
   version="1.1"
   id="svg5"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:svg="http://www.w3.org/2000/svg">
  <defs
     id="defs2" />
  <g
     id="layer1">
    <rect
       style="fill:#00ffff;stroke-width:0.999999;-inkscape-stroke:none;stop-color:#000000"
       id="rect234"
       width="26.458334"
       height="26.458334"
       x="0"
       y="-2.5796816e-15"
       rx="3.96875"
       ry="3.96875" />
    <circle
       style="fill:#000080;stroke-width:1;-inkscape-stroke:none;stop-color:#000000"
       id="path948"
       cx="39.6875"
       cy="13.229167"
       r="13.229167" />
    <path
       style="fill:#0000ff;stroke-width:0.999994;-inkscape-stroke:none;stop-color:#000000"
       d="M 53.214737,22.670915 64.203125,1.2484603 a 2.231071,2.4562591 0 0 1 3.885418,10e-8 L 79.07693,22.670915 a 2.3061863,2.538956 0 0 1 -2.008116,3.787417 H 55.222853 a 2.3061862,2.5389559 0 0 1 -2.008116,-3.787417 z"
       id="path1058" />
  </g>
</svg>'

	


]

{ #category : #running }
ASVGMorphTest >> setUp [ 

	super setUp.
	
]

{ #category : #running }
ASVGMorphTest >> tearDown [ 
	
	super tearDown.
	
]

{ #category : #tests }
ASVGMorphTest >> testSvgIcon [ 

	| morph |
	morph := ASVGMorph new
		svg: (AthensSVGConverter new importXMLDocument: (XMLDOMParser parse: self class iconSVGFileContent));
	yourself.
	
	self assert: (morph isKindOf: Morph).
]

{ #category : #tests }
ASVGMorphTest >> testSvgInkscape [

	| morph |
	morph := ASVGMorph new
		svg: (AthensSVGConverter new importXMLDocument: (XMLDOMParser parse: self class inkscapeSVGFileContent));
	yourself.
	
	self assert: (morph isKindOf: Morph).
]
