Class {
	#name : #ASStyle,
	#superclass : #ASElement,
	#category : #'Athens-SVG'
}

{ #category : #translate }
ASStyle >> translate: xmlNode [

	| classNode classDecls className  cssClass |
	
	classNode := xmlNode nodes first.
	classNode isClassDeclNode ifFalse: [^ self].
	classDecls := (classNode string reject: #isSeparator) splitOn: $}.
	(classDecls allButLast: 1) do: [ :classText |
			| startBracePosition |
			startBracePosition := classText indexOf: ${.
			className := classText copyFrom: 2 to: startBracePosition - 1.
			cssClass := self root cssClasses at: className
						ifAbsentPut: 
							[(CssClass new)
								identifier: className;
								yourself].
			cssClass
				cssFromAttributes: (classText copyFrom: startBracePosition
						to: classText size) , '}'].
]
