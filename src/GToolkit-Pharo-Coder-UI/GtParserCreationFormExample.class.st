Class {
	#name : #GtParserCreationFormExample,
	#superclass : #GtCreationFormExample,
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #accessing }
GtParserCreationFormExample >> examplePackageName [
	^ 'ExamplePackage'
]

{ #category : #accessing }
GtParserCreationFormExample >> exampleParserName [
	^ 'ExampleParser'
]

{ #category : #accessing }
GtParserCreationFormExample >> exampleScannerName [
	^ 'ExampleScanner'
]

{ #category : #accessing }
GtParserCreationFormExample >> formClass [
	^ GtParserCreationForm
]

{ #category : #accessing }
GtParserCreationFormExample >> removeParserAndPackage [
	Smalltalk
		removeClassNamed: self exampleParserName;
		removeClassNamed: self exampleScannerName.
	self examplePackageName asPackage removeFromSystem
]

{ #category : #accessing }
GtParserCreationFormExample >> scripterOnSimpleForm [
	<gtExample>
	| tmp1 |
	tmp1 := self scripterWithModel: [ self simpleForm ].
	tmp1
		assertStep: [ :arg1 | 
			arg1
				label: 'Check save button is disabled';
				satisfies: [ :arg2 | ((arg2 childNamed: #toolbar) childAt: 1) isEnabled not ] ].
	^ tmp1
]

{ #category : #accessing }
GtParserCreationFormExample >> scripterWithParserAccepted [
	<gtExample>
	<after: #removeParserAndPackage>
	| tmp1 tmp2 |
	tmp1 := self scripterWithParserAndScannerNameAndPackageFilled.
	tmp1
		clickStep: [ :arg1 | 
			arg1
				label: 'Click save button';
				// #toolbar;
				onChildAt: 1 ].
	tmp2 := Smalltalk classNamed: self exampleParserName.
	self assert: tmp2 isNotNil.
	tmp2 := Smalltalk classNamed: self exampleScannerName.
	self assert: tmp2 isNotNil.
	^ tmp1
]

{ #category : #accessing }
GtParserCreationFormExample >> scripterWithParserAndScannerNameAndPackageFilled [
	<gtExample>
	| tmp1 tmp2 tmp3 tmp5 |
	tmp1 := self scripterWithParserAndScannerNameFilled.
	tmp2 := tmp1 model packageAndTagDescription.
	tmp3 := GtMagritteFieldElementId new description: tmp2.
	tmp2 := tmp1 model packageAndTagDescription.
	tmp3 := GtMagritteFieldElementId new description: tmp2.
	tmp5 := tmp1 requestFocus.
	tmp5
		label: 'Focus package editor';
		// tmp3;
		onChildAt: 1;
		play.
	tmp1
		typeStep: [ :arg1 | 
			arg1
				label: 'Fill package name';
				text: self examplePackageName;
				// tmp3;
				onChildAt: 1 ];
		assertStep: [ :arg2 | 
				arg2
					label: 'Check that package is set';
					satisfies: [ :arg3 | 
							((arg3 userData at: #gtmemento) cache at: tmp2) valueOrNil currentValue
								packageName = self examplePackageName ] ].
	^ tmp1
]

{ #category : #accessing }
GtParserCreationFormExample >> scripterWithParserAndScannerNameFilled [
	<gtExample>
	| tmp1 tmp2 tmp3 tmp5 |
	tmp1 := self scripterWithParserNameFilled.
	tmp2 := tmp1 model scannerDescription.
	tmp3 := GtMagritteFieldElementId new description: tmp2.
	tmp5 := tmp1 requestFocus.
	tmp5
		label: 'Focus scanner editor';
		// tmp3;
		play.
	tmp1
		typeStep: [ :arg1 | 
			arg1
				label: 'Fill scanner name';
				text: self exampleScannerName;
				// tmp3 ];
		assertStep: [ :arg2 | 
				arg2
					label: 'Assert scanner name';
					value: [ :arg3 | arg3 text asString ] equals: [ self exampleScannerName ];
					// tmp3 ].
	^ tmp1
]

{ #category : #accessing }
GtParserCreationFormExample >> scripterWithParserNameFilled [
	<gtExample>
	| tmp1 tmp2 tmp3 tmp5 |
	tmp1 := self scripterOnSimpleForm.
	tmp2 := tmp1 model parserDescription.
	tmp3 := GtMagritteFieldElementId new description: tmp2.
	tmp5 := tmp1 requestFocus.
	tmp5
		label: 'Focus parser editor';
		// tmp3;
		play.
	tmp1
		typeStep: [ :arg1 | 
			arg1
				label: 'Fill parser name';
				text: self exampleParserName;
				// tmp3 ];
		assertStep: [ :arg2 | 
				arg2
					label: 'Assert parser name';
					value: [ :arg3 | arg3 text asString ] equals: [ self exampleParserName ];
					// tmp3 ].
	^ tmp1
]

{ #category : #accessing }
GtParserCreationFormExample >> simpleForm [
	<gtExample>
	^ self formClass new
]
