Class {
	#name : #GtBaselineCreationForm,
	#superclass : #GtCreationForm,
	#instVars : [
		'baseline'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtBaselineCreationForm class >> componentName [
	^ 'Baseline'
]

{ #category : #accessing }
GtBaselineCreationForm class >> priority [
	^ 4
]

{ #category : #accessing }
GtBaselineCreationForm >> baseline [
	^ baseline
]

{ #category : #accessing }
GtBaselineCreationForm >> baseline: arg1 [
	baseline := arg1
]

{ #category : #magritte }
GtBaselineCreationForm >> baselineDescription [
	<magritteDescription>
	| tmp2 |
	tmp2 := MAStringDescription new.
	tmp2
		label: 'Baseline';
		priority: 1;
		accessor: #baselineRope;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		blocCompletion: [ GtStringsCompletionStrategy new
					completions: (GtPrefixTree withAll: (Smalltalk allClasses collect: #name)) ];
		addCondition: [ :arg1 | arg1 asString trim isNotEmpty ]
			labelled: 'Baseline name must be set';
		addCondition: [ :arg2 | (Smalltalk classNamed: arg2 asString trim) isNil ]
			labelled: 'Baseline name is already taken';
		addCondition: [ :arg3 | arg3 beginsWith: 'BaselineOf' ]
			labelled: 'Baseline name must start with BaselineOf';
		addCondition: [ :arg4 | arg4 asString isAllAlphaNumerics ]
			labelled: 'Baseline name must be alphanumeric'.
	^ tmp2 beRequired
]

{ #category : #accessing }
GtBaselineCreationForm >> baselineRope [
	^ self baseline asRopedText
		ifEmpty: [ self baseline asRopedText
				attribute: (self ghostTextFor: self defaultBaselineName) ]
]

{ #category : #accessing }
GtBaselineCreationForm >> baselineRope: arg1 [
	self baseline: arg1 asString
]

{ #category : #callbacks }
GtBaselineCreationForm >> commit [
	^ Smalltalk classInstaller
		make: [ :arg1 | 
			arg1
				name: baseline trim;
				superclass: BaselineOf;
				category: baseline trim ]
]

{ #category : #accessing }
GtBaselineCreationForm >> defaultBaselineName [
	^ 'BaselineOfExample'
]

{ #category : #magritte }
GtBaselineCreationForm >> hasPackageAndTag [
	^ false
]

{ #category : #accessing }
GtBaselineCreationForm >> initialize [
	baseline := ''
]

{ #category : #magritte }
GtBaselineCreationForm >> packageAndTagDescription [
	^ nil
]
