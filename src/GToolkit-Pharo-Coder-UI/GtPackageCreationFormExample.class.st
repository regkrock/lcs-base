Class {
	#name : #GtPackageCreationFormExample,
	#superclass : #GtCreationFormExample,
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #accessing }
GtPackageCreationFormExample >> examplePackageName [
	^ 'MyExamplePackage'
]

{ #category : #accessing }
GtPackageCreationFormExample >> formClass [
	^ GtPackageCreationForm
]

{ #category : #accessing }
GtPackageCreationFormExample >> removePackage [
	self examplePackageName asPackage removeFromSystem
]

{ #category : #accessing }
GtPackageCreationFormExample >> scripterOnSimpleForm [
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
GtPackageCreationFormExample >> simpleForm [
	<gtExample>
	^ self formClass new
]

{ #category : #accessing }
GtPackageCreationFormExample >> simpleFormWithPackageAdded [
	<gtExample>
	<after: #removePackage>
	| tmp1 tmp2 |
	tmp1 := self simpleFormWithPackageFilled.
	tmp1
		clickStep: [ :arg1 | 
			arg1
				label: 'Click save button';
				// #toolbar;
				onChildAt: 1 ].
	tmp2 := self examplePackageName asPackageIfAbsent: nil.
	self assert: tmp2 isNotNil.
	^ tmp1
]

{ #category : #accessing }
GtPackageCreationFormExample >> simpleFormWithPackageFilled [
	<gtExample>
	| tmp1 |
	tmp1 := self scripterOnSimpleForm.
	tmp1
		clickStep: [ :arg1 | 
			arg1
				label: 'Select package editor';
				// (GtMagritteFieldElementId new description: tmp1 model packageAndTagDescription);
				// #package ];
		typeStep: [ :arg2 | 
				arg2
					label: 'Enter package name';
					text: self examplePackageName ];
		checkStep: [ :arg3 | 
				arg3
					label: 'Check that package is set';
					satisfies: [ :arg4 | 
							(arg4 userData at: #gtmemento) cache anyOne valueOrNil currentValue packageName
								= self examplePackageName ] ].
	^ tmp1
]

{ #category : #accessing }
GtPackageCreationFormExample >> simpleFormWithPackageFilledValidationFailed [
	<gtExample>
	| tmp1 |
	tmp1 := self scripterOnSimpleForm.
	tmp1
		clickStep: [ :arg1 | 
			arg1
				label: 'Select package editor';
				// (GtMagritteFieldElementId new description: tmp1 model packageAndTagDescription);
				// #package ];
		typeStep: [ :arg2 | 
				arg2
					label: 'Enter package name';
					text: 'Kernel' ];
		checkStep: [ :arg3 | 
				arg3
					label: 'Check that package is invalid';
					satisfies: [ :arg4 | (arg4 userData at: #gtmemento) cache anyOne valueOrNil isValid not ] ].
	^ tmp1
]

{ #category : #accessing }
GtPackageCreationFormExample >> simpleFormWithTagNavigated [
	<gtExample>
	| tmp1 tmp3 |
	tmp1 := self simpleFormWithPackageFilled.
	tmp3 := tmp1 shortcut.
	tmp3
		label: 'Navigate to tag';
		combination: BlKeyCombination tab;
		play.
	^ tmp1
]
