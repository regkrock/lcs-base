Class {
	#name : #GtBaselineCreationFormExample,
	#superclass : #GtCreationFormExample,
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #accessing }
GtBaselineCreationFormExample >> exampleBaselineName [
	^ 'BaselineOfMyExample'
]

{ #category : #accessing }
GtBaselineCreationFormExample >> exampleBaselineNameTaken [
	^ 'BaselineOfGToolkit'
]

{ #category : #accessing }
GtBaselineCreationFormExample >> formClass [
	^ GtBaselineCreationForm
]

{ #category : #accessing }
GtBaselineCreationFormExample >> removeBaseline [
	Smalltalk removeClassNamed: self exampleBaselineName.
	self exampleBaselineName asPackage removeFromSystem
]

{ #category : #accessing }
GtBaselineCreationFormExample >> scripterOnSimpleForm [
	<gtExample>
	| tmp1 |
	tmp1 := self scripterWithModel: [ self simpleForm ].
	tmp1
		checkStep: [ :arg1 | 
			arg1
				label: 'Check save button is disabled';
				satisfies: [ :arg2 | ((arg2 childNamed: #toolbar) childAt: 1) isEnabled not ] ].
	^ tmp1
]

{ #category : #accessing }
GtBaselineCreationFormExample >> simpleForm [
	<gtExample>
	^ self formClass new
]

{ #category : #accessing }
GtBaselineCreationFormExample >> simpleFormWithBaselineAccepted [
	<gtExample>
	<after: #removeBaseline>
	| tmp1 tmp2 |
	tmp1 := self simpleFormWithBaselineFilled.
	tmp1
		checkStep: [ :arg1 | 
			arg1
				label: 'Check save button is enabled';
				satisfies: [ :arg2 | ((arg2 childNamed: #toolbar) childAt: 1) isEnabled ] ];
		clickStep: [ :arg3 | 
				arg3
					label: 'Click save button';
					id: #toolbar;
					onChildAt: 1 ].
	tmp2 := Smalltalk classNamed: self exampleBaselineName.
	self assert: tmp2 isNotNil.
	^ tmp1
]

{ #category : #accessing }
GtBaselineCreationFormExample >> simpleFormWithBaselineFilled [
	<gtExample>
	| tmp1 |
	tmp1 := self scripterOnSimpleForm.
	tmp1
		clickStep: [ :arg1 | 
			arg1
				label: 'Select baseline editor';
				// (GtMagritteFieldElementId new description: tmp1 model baselineDescription) ];
		typeStep: [ :arg2 | 
				arg2
					label: 'Enter baseline name';
					text: self exampleBaselineName ];
		assertStep: [ :arg3 | 
				arg3
					label: 'Check that baseline is set';
					satisfies: [ :arg4 | 
							(arg4 userData at: #gtmemento) cache anyOne valueOrNil currentValue
								= self exampleBaselineName ] ].
	^ tmp1
]

{ #category : #accessing }
GtBaselineCreationFormExample >> simpleFormWithBaselineFilledValidationFailed [
	<gtExample>
	| tmp1 |
	tmp1 := self scripterOnSimpleForm.
	tmp1
		clickStep: [ :arg1 | 
			arg1
				label: 'Select baseline editor';
				// (GtMagritteFieldElementId new description: tmp1 model baselineDescription) ];
		typeStep: [ :arg2 | 
				arg2
					label: 'Enter baseline name';
					text: self exampleBaselineNameTaken ];
		assertStep: [ :arg3 | 
				arg3
					label: 'Check that baseline is invalid';
					satisfies: [ :arg4 | (arg4 userData at: #gtmemento) cache anyOne valueOrNil isValid not ] ].
	^ tmp1
]

{ #category : #accessing }
GtBaselineCreationFormExample >> simpleFormWithEditingCancelled [
	<gtExample>
	| tmp1 |
	tmp1 := self simpleFormWithBaselineFilled.
	tmp1
		checkStep: [ :arg1 | 
			arg1
				label: 'Check cancel button is enabled';
				satisfies: [ :arg2 | ((arg2 childNamed: #toolbar) childAt: 2) isEnabled ] ];
		clickStep: [ :arg3 | 
				arg3
					label: 'Click cancel button';
					id: #toolbar;
					onChildAt: 2 ];
		assertStep: [ :arg4 | 
				arg4
					label: 'Check that baseline is reset';
					satisfies: [ :arg5 | 
							(arg5 userData at: #gtmemento) cache anyOne valueOrNil currentValue asString
								= '' ] ].
	^ tmp1
]
