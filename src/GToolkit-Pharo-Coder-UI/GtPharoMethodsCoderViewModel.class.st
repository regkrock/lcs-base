Class {
	#name : #GtPharoMethodsCoderViewModel,
	#superclass : #GtMultipleCodersViewModel,
	#instVars : [
		'focusedCoderUIModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! View Models'
}

{ #category : #'api - interations' }
GtPharoMethodsCoderViewModel >> addNewCoder [
	| tmp1 |
	tmp1 := self coder addNewCoder.
	self
		expandCoder: tmp1;
		focusCoder: tmp1.
	^ tmp1
]

{ #category : #updating }
GtPharoMethodsCoderViewModel >> coderUIModelFor: arg1 [
	| tmp2 |
	tmp2 := arg1 asCoderViewModel.
	tmp2 expanded: false.
	^ tmp2 selfObject: self coder object
]

{ #category : #accessing }
GtPharoMethodsCoderViewModel >> elementClass [
	^ GtPharoMethodsCoderElement
]

{ #category : #'api - interations' }
GtPharoMethodsCoderViewModel >> expandCoder: arg1 [
	coderUIModels
		detect: [ :arg2 | arg2 coder = arg1 ]
		ifFound: [ :arg3 | arg3 expanded: true ]
]

{ #category : #'api - interations' }
GtPharoMethodsCoderViewModel >> focusCoder: arg1 [
	coderUIModels
		detect: [ :arg2 | arg2 coder = arg1 ]
		ifFound: [ :arg3 | self focusCoderUIModel: arg3 ]
]

{ #category : #'api - focus' }
GtPharoMethodsCoderViewModel >> focusCoderUIModel: arg1 [
	(focusedCoderUIModel notNil and: [ focusedCoderUIModel ~= arg1 ])
		ifTrue: [ focusedCoderUIModel focused: false.
			focusedCoderUIModel := nil ].
	focusedCoderUIModel := arg1.
	focusedCoderUIModel focused: true
]

{ #category : #accessing }
GtPharoMethodsCoderViewModel >> focusedCoderUIModel [
	<return: #GtSingleCoderViewModel>
	^ focusedCoderUIModel
]

{ #category : #'api - focus' }
GtPharoMethodsCoderViewModel >> unfocusCoderUIModel: arg1 [
	focusedCoderUIModel = arg1 ifTrue: [ focusedCoderUIModel := nil ].
	arg1 hasFocus: false
]
