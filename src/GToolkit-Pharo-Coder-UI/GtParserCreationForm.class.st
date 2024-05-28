Class {
	#name : #GtParserCreationForm,
	#superclass : #GtCreationForm,
	#instVars : [
		'parser',
		'scanner'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtParserCreationForm class >> componentName [
	^ 'Parser'
]

{ #category : #accessing }
GtParserCreationForm class >> priority [
	^ 5
]

{ #category : #callbacks }
GtParserCreationForm >> commit [
	| tmp1 tmp2 tmp3 |
	tmp1 := self commitPackage categoryName.
	tmp2 := Smalltalk classInstaller
			make: [ :arg1 | 
				arg1
					name: scanner trim;
					superclass: SmaCCScanner;
					category: tmp1 ].
	tmp3 := Smalltalk classInstaller
			make: [ :arg2 | 
				arg2
					name: parser trim;
					superclass: SmaCCParser;
					category: tmp1 ].
	(RBAddMethodChange
		compile: 'scannerClass
	^' , scanner
		in: tmp3 class
		classified: #generated) execute.
	(RBAddMethodChange
		compile: 'definitionComment
	"Start 
	:
	;"'
		in: tmp3 class
		classified: #generated) execute.
	^ tmp3
]

{ #category : #accessing }
GtParserCreationForm >> defaultParser [
	^ 'SomeParser'
]

{ #category : #accessing }
GtParserCreationForm >> defaultScanner [
	^ 'SomeScanner'
]

{ #category : #initialization }
GtParserCreationForm >> initialize [
	super initialize.
	parser := ''.
	scanner := ''
]

{ #category : #accessing }
GtParserCreationForm >> parser [
	^ parser
]

{ #category : #accessing }
GtParserCreationForm >> parser: arg1 [
	parser := arg1
]

{ #category : #magritte }
GtParserCreationForm >> parserDescription [
	<magritteDescription>
	| tmp2 |
	tmp2 := MAStringDescription new.
	tmp2
		label: 'Parser';
		priority: 1;
		accessor: #parserRope;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		blocCompletion: [ GtStringsCompletionStrategy new
					completions: (GtPrefixTree withAll: (Smalltalk allClasses collect: #name)) ];
		addCondition: [ :arg1 | arg1 asString trim isNotEmpty ]
			labelled: 'Parser name must be set';
		addCondition: [ :arg2 | (Smalltalk classNamed: arg2 asString trim) isNil ]
			labelled: 'Class name is already taken';
		addCondition: [ :arg3 | arg3 isEmpty or: [ arg3 asString first isUppercase ] ]
			labelled: 'First character must be uppercase';
		addCondition: [ :arg4 | arg4 asString isAllAlphaNumerics ]
			labelled: 'Class name must be alphanumeric'.
	^ tmp2 beRequired
]

{ #category : #accessing }
GtParserCreationForm >> parserRope [
	^ self parser asRopedText
		ifEmpty: [ self parser asRopedText attribute: (self ghostTextFor: self defaultParser) ]
]

{ #category : #accessing }
GtParserCreationForm >> parserRope: arg1 [
	self parser: arg1 asString
]

{ #category : #accessing }
GtParserCreationForm >> scanner [
	^ scanner
]

{ #category : #accessing }
GtParserCreationForm >> scanner: arg1 [
	scanner := arg1
]

{ #category : #magritte }
GtParserCreationForm >> scannerDescription [
	<magritteDescription>
	| tmp2 |
	tmp2 := MAStringDescription new.
	tmp2
		label: 'Scanner';
		priority: 2;
		accessor: #scannerRope;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		blocCompletion: [ GtStringsCompletionStrategy new
					completions: (GtPrefixTree withAll: (Smalltalk allClasses collect: #name)) ];
		addCondition: [ :arg1 | arg1 asString trim isNotEmpty ]
			labelled: 'Scanner name must be set';
		addCondition: [ :arg2 | (Smalltalk classNamed: arg2 asString trim) isNil ]
			labelled: 'Class name is already taken';
		addCondition: [ :arg3 | arg3 isEmpty or: [ arg3 asString first isUppercase ] ]
			labelled: 'First character must be uppercase';
		addCondition: [ :arg4 | arg4 asString isAllAlphaNumerics ]
			labelled: 'Class name must be alphanumeric'.
	^ tmp2 beRequired
]

{ #category : #accessing }
GtParserCreationForm >> scannerRope [
	^ self scanner asRopedText
		ifEmpty: [ self scanner asRopedText attribute: (self ghostTextFor: self defaultScanner) ]
]

{ #category : #accessing }
GtParserCreationForm >> scannerRope: arg1 [
	self scanner: arg1 asString
]
