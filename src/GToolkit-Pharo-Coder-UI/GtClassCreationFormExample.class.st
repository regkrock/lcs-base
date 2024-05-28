Class {
	#name : #GtClassCreationFormExample,
	#superclass : #GtCreationFormExample,
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #accessing }
GtClassCreationFormExample >> classWithTwoTraitsDefinitionString [
	^ 'Object subclass: #ExampleClass uses: TGtPharoDummyTraitOne + TGtPharoDummyTraitTwo instanceVariableNames: '''' classVariableNames: '''' poolDictionaries: '''' package: ''ExamplePackage'''
]

{ #category : #accessing }
GtClassCreationFormExample >> exampleClassName [
	^ 'ExampleClass'
]

{ #category : #accessing }
GtClassCreationFormExample >> examplePackageName [
	^ 'ExamplePackage'
]

{ #category : #accessing }
GtClassCreationFormExample >> formClass [
	^ GtClassCreationForm
]

{ #category : #accessing }
GtClassCreationFormExample >> removeClassAndPackage [
	Smalltalk removeClassNamed: self exampleClassName.
	self examplePackageName asPackage removeFromSystem
]

{ #category : #accessing }
GtClassCreationFormExample >> scripterOnSimpleForm [
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
GtClassCreationFormExample >> scripterWithClassAccepted [
	<gtExample>
	<after: #removeClassAndPackage>
	| tmp1 tmp2 |
	tmp1 := self scripterWithClassNameAndPackageFilled.
	tmp1
		clickStep: [ :arg1 | 
			arg1
				label: 'Click save button';
				// #toolbar;
				onChildAt: 1 ].
	tmp2 := Smalltalk classNamed: self exampleClassName.
	self assert: tmp2 isNotNil.
	^ tmp1
]

{ #category : #accessing }
GtClassCreationFormExample >> scripterWithClassNameAndPackageFilled [
	<gtExample>
	| tmp1 tmp2 tmp3 tmp5 |
	tmp1 := self scripterWithClassNameFilled.
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
GtClassCreationFormExample >> scripterWithClassNameFilled [
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
				label: 'Fill class name';
				text: self exampleClassName;
				// tmp3 ];
		assertStep: [ :arg2 | 
				arg2
					label: 'Assert class name';
					value: [ :arg3 | arg3 text asString ] equals: [ self exampleClassName ];
					// tmp3 ].
	^ tmp1
]

{ #category : #accessing }
GtClassCreationFormExample >> scripterWithClassNameFilledValidationFailed [
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
				label: 'Fill class name';
				text: 'Object';
				// tmp3 ];
		assertStep: [ :arg2 | 
				arg2
					label: 'Check that class name is invalid';
					satisfies: [ :arg3 | ((arg3 userData at: #gtmemento) cache at: tmp2) valueOrNil isValid not ] ].
	^ tmp1
]

{ #category : #accessing }
GtClassCreationFormExample >> scripterWithClassNamePackageAndTwoConflictingTraitsFilled [
	<gtExample>
	| tmp1 tmp2 tmp3 tmp4 tmp6 |
	tmp1 := self scripterWithClassNameAndPackageFilled.
	tmp2 := tmp1 model traitsDescription.
	tmp3 := GtMagritteFieldElementId new description: tmp2.
	tmp4 := GtMagritteValidatorElementId new description: tmp2.
	tmp6 := tmp1 click.
	tmp6
		label: 'Add Trait';
		// tmp3;
		onChildAt: 1;
		play.
	tmp1
		typeStep: [ :arg1 | 
			arg1
				label: 'Fill Trait name';
				text: TGtPharoDummyTraitOne name;
				// tmp3;
				onChildAt: 1 ];
		assertStep: [ :arg2 | 
				arg2
					label: 'Assert that Trait is set';
					satisfies: [ :arg3 | 
							((arg3 userData at: #gtmemento) cache at: tmp2) valueOrNil currentValue
								= {TGtPharoDummyTraitOne name} ] ];
		shortcutStep: [ :arg4 | 
				arg4
					label: 'Next Trait';
					combination: BlKeyCombination tab;
					// tmp3;
					/ #tags;
					onChildAt: 1 ];
		typeStep: [ :arg5 | 
				arg5
					label: 'Fill Trait name';
					text: TGtPharoDummyTraitThree name;
					// tmp3;
					/ #tags;
					onChildAt: 2 ];
		assertStep: [ :arg6 | 
				arg6
					label: 'Assert that both Traits are set';
					satisfies: [ :arg7 | 
							((arg7 userData at: #gtmemento) cache at: tmp2) valueOrNil currentValue
								= {TGtPharoDummyTraitOne name.
										TGtPharoDummyTraitThree name} ] ];
		assertStep: [ :arg8 | 
				arg8
					label: 'Assert conflicting Traits message';
					value: [ :arg9 | arg9 text asString ] equals: 'Conflicting Traits';
					// tmp4;
					// GtMagritteIssuesExplanationId ].
	^ tmp1
]

{ #category : #accessing }
GtClassCreationFormExample >> scripterWithClassNamePackageAndTwoTraitsFilled [
	<gtExample>
	| tmp1 tmp2 tmp3 tmp5 |
	tmp1 := self scripterWithClassNameAndPackageFilled.
	tmp2 := tmp1 model traitsDescription.
	tmp3 := GtMagritteFieldElementId new description: tmp2.
	tmp5 := tmp1 click.
	tmp5
		label: 'Add Trait';
		// tmp3;
		onChildAt: 1;
		play.
	tmp1
		typeStep: [ :arg1 | 
			arg1
				label: 'Fill Trait name';
				text: TGtPharoDummyTraitOne name;
				// tmp3;
				onChildAt: 1 ];
		assertStep: [ :arg2 | 
				arg2
					label: 'Assert that Trait is set';
					satisfies: [ :arg3 | 
							((arg3 userData at: #gtmemento) cache at: tmp2) valueOrNil currentValue
								= {TGtPharoDummyTraitOne name} ] ];
		shortcutStep: [ :arg4 | 
				arg4
					label: 'Next Trait';
					combination: BlKeyCombination tab;
					// tmp3;
					/ #tags;
					onChildAt: 1 ];
		typeStep: [ :arg5 | 
				arg5
					label: 'Fill Trait name';
					text: TGtPharoDummyTraitTwo name;
					// tmp3;
					/ #tags;
					onChildAt: 2 ];
		assertStep: [ :arg6 | 
				arg6
					label: 'Assert that both Traits are set';
					satisfies: [ :arg7 | 
							((arg7 userData at: #gtmemento) cache at: tmp2) valueOrNil currentValue
								= {TGtPharoDummyTraitOne name.
										TGtPharoDummyTraitTwo name} ] ];
		doStep: [ :arg8 | 
				arg8
					label: 'Accept form changes (without defining a class)';
					block: [ :arg9 | (arg9 userData at: #gtmemento) commit ] ];
		assertStep: [ :arg10 | 
				arg10
					label: 'Assert class code';
					value: [ :arg11 | arg11 classDefinitionString ]
						equals: self classWithTwoTraitsDefinitionString;
					onModel ].
	^ tmp1
]

{ #category : #accessing }
GtClassCreationFormExample >> simpleForm [
	<gtExample>
	^ self formClass new
]
