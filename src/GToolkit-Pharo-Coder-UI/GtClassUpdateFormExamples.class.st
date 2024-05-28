Class {
	#name : #GtClassUpdateFormExamples,
	#superclass : #GtCreationFormExample,
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #accessing }
GtClassUpdateFormExamples >> examplePackageName [
	^ 'ExamplePackage'
]

{ #category : #accessing }
GtClassUpdateFormExamples >> formClass [
	^ GtClassUpdateForm
]

{ #category : #accessing }
GtClassUpdateFormExamples >> scripterOnSimpleForm [
	<gtExample>
	| tmp1 |
	tmp1 := self scripterWithModel: [ self simpleForm ].
	tmp1
		checkStep: [ :arg1 | 
			arg1
				label: 'Check save button is enabled';
				satisfies: [ :arg2 | ((arg2 childNamed: #toolbar) childAt: 1) isEnabled ] ].
	^ tmp1
]

{ #category : #accessing }
GtClassUpdateFormExamples >> scripterWithClassNameAndPackageFilled [
	<gtExample>
	| tmp1 tmp2 tmp3 tmp5 |
	tmp1 := self scripterOnSimpleForm.
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
GtClassUpdateFormExamples >> simpleForm [
	<gtExample>
	^ self formClass onClass: Object
]
