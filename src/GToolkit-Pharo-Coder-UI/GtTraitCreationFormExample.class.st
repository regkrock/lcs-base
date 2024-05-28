Class {
	#name : #GtTraitCreationFormExample,
	#superclass : #GtCreationFormExample,
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #accessing }
GtTraitCreationFormExample >> examplePackageName [
	^ 'ExamplePackage'
]

{ #category : #accessing }
GtTraitCreationFormExample >> exampleTraitName [
	^ 'TExampleTrait'
]

{ #category : #accessing }
GtTraitCreationFormExample >> formClass [
	^ GtTraitCreationForm
]

{ #category : #accessing }
GtTraitCreationFormExample >> removeTraitAndPackage [
	Smalltalk removeClassNamed: self exampleTraitName.
	self examplePackageName asPackage removeFromSystem
]

{ #category : #accessing }
GtTraitCreationFormExample >> scripterOnSimpleForm [
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
GtTraitCreationFormExample >> scripterWithSlotsFilled [
	<gtExample>
	| tmp1 tmp2 |
	tmp1 := self scripterWithSlotsNavigated.
	tmp2 := tmp1 model slotsDescription.
	tmp1
		typeStep: [ :arg1 | 
			arg1
				label: 'Fill first slot';
				text: 'abc' ];
		keyPressStep: [ :arg2 | 
				arg2
					label: 'Tab to next slot';
					key: BlKeyboardKey tab ];
		typeStep: [ :arg3 | 
				arg3
					label: 'Fill second slot';
					text: 'bcd' ];
		assertStep: [ :arg4 | 
				arg4
					label: 'Check that slots are set';
					satisfies: [ :arg5 | 
							((arg5 userData at: #gtmemento) cache at: tmp2) valueOrNil currentValue
								= {'abc'.
										'bcd'} ] ].
	^ tmp1
]

{ #category : #accessing }
GtTraitCreationFormExample >> scripterWithSlotsNavigated [
	<gtExample>
	| tmp1 tmp2 tmp3 |
	tmp1 := self scripterWithTraitNameAndPackageFilled.
	tmp2 := tmp1 model packageAndTagDescription.
	tmp3 := GtMagritteFieldElementId new description: tmp2.
	tmp1
		keyPressStep: [ :arg1 | 
			arg1
				label: 'Tab to tag editor';
				key: BlKeyboardKey tab ];
		keyPressStep: [ :arg2 | 
				arg2
					label: 'Tab to slots';
					key: BlKeyboardKey tab ].
	^ tmp1
]

{ #category : #accessing }
GtTraitCreationFormExample >> scripterWithTraitAccepted [
	<after: #removeTraitAndPackage>
	<gtExample>
	| tmp1 tmp2 |
	tmp1 := self scripterWithSlotsFilled.
	tmp1
		clickStep: [ :arg1 | 
			arg1
				label: 'Click save button';
				// #toolbar;
				onChildAt: 1 ].
	tmp2 := Smalltalk classNamed: self exampleTraitName.
	self
		assert: tmp2 isNotNil;
		assert: (tmp2 slots collect: #name)
			equals: {'abc'.
						'bcd'}.
	^ tmp1
]

{ #category : #accessing }
GtTraitCreationFormExample >> scripterWithTraitNameAndPackageFilled [
	<gtExample>
	| tmp1 tmp2 tmp3 tmp5 |
	tmp1 := self scripterWithTraitNameFilled.
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
GtTraitCreationFormExample >> scripterWithTraitNameFilled [
	<gtExample>
	| tmp1 tmp2 tmp3 tmp5 |
	tmp1 := self scripterOnSimpleForm.
	tmp2 := tmp1 model nameDescription.
	tmp3 := GtMagritteFieldElementId new description: tmp2.
	tmp5 := tmp1 requestFocus.
	tmp5
		label: 'Focus name editor';
		// tmp3;
		play.
	tmp1
		typeStep: [ :arg1 | 
			arg1
				label: 'Fill trait name';
				text: self exampleTraitName;
				// tmp3 ];
		assertStep: [ :arg2 | 
				arg2
					label: 'Assert trait name';
					value: [ :arg3 | arg3 text asString ] equals: [ self exampleTraitName ];
					// tmp3 ].
	^ tmp1
]

{ #category : #accessing }
GtTraitCreationFormExample >> scripterWithTraitNameFilledValidationFailed [
	<gtExample>
	| tmp1 tmp2 tmp3 tmp5 |
	tmp1 := self scripterOnSimpleForm.
	tmp2 := tmp1 model nameDescription.
	tmp3 := GtMagritteFieldElementId new description: tmp2.
	tmp5 := tmp1 requestFocus.
	tmp5
		label: 'Focus name editor';
		// tmp3;
		play.
	tmp1
		typeStep: [ :arg1 | 
			arg1
				label: 'Fill trait name';
				text: 'Object';
				// tmp3 ];
		assertStep: [ :arg2 | 
				arg2
					label: 'Check that trait name is invalid';
					satisfies: [ :arg3 | ((arg3 userData at: #gtmemento) cache at: tmp2) valueOrNil isValid not ] ].
	^ tmp1
]

{ #category : #accessing }
GtTraitCreationFormExample >> simpleForm [
	<gtExample>
	^ self formClass new
]
