"
An SVG Polyline
"
Class {
	#name : #ASPolyLine,
	#superclass : #ASPolygon,
	#category : #'Athens-SVG-Base'
}

{ #category : #'private - rendering' }
ASPolyLine >> setShapeOn: aCanvas [
	| path |

	path := aCanvas createPath: [:builder |
		builder
			absolute;
			moveTo: points first.

		points allButFirstDo: [:pt | builder lineTo: pt ].


	].

	aCanvas setShape: path
]
