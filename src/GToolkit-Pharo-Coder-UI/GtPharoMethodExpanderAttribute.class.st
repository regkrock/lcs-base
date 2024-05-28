Class {
	#name : #GtPharoMethodExpanderAttribute,
	#superclass : #BrGlamorousTriangleExpanderTextAttribute,
	#instVars : [
		'classOrMetaClass',
		'selector',
		'argumentBindingsBuilder'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Attributes'
}

{ #category : #'instance creation' }
GtPharoMethodExpanderAttribute class >> forClass: arg1 andSelector: arg2 [
	| tmp2 |
	tmp2 := self new.
	tmp2 forClass: arg1 andSelector: arg2.
	^ tmp2 yourself
]

{ #category : #accessing }
GtPharoMethodExpanderAttribute >> argumentBindingsBuilder [
	<return: #GtPharoReceiverAndArgumentBindingsBuilder>
	^ argumentBindingsBuilder
]

{ #category : #accessing }
GtPharoMethodExpanderAttribute >> argumentBindingsBuilder: arg1 [
	argumentBindingsBuilder := arg1
]

{ #category : #private }
GtPharoMethodExpanderAttribute >> buildMethodCoder [
	| tmp1 tmp2 tmp3 tmp4 |
	(tmp3 := self compiledMethod) ifNil: [ ^ BlElement new ].
	tmp2 := GtPharoMethodCoder forMethod: tmp3.
	tmp2 subscribeToSystem.
	tmp4 := tmp2 asCoderViewModel.
	self configureViewModel: tmp4 andCoder: tmp2.
	tmp1 := tmp4 asElement.
	self id isIndexed
		ifTrue: [ tmp1 id: (GtPharoEmbeddedMethodId indexed: self id index) ]
		ifFalse: [ tmp1 id: GtPharoEmbeddedMethodId ].
	tmp1
		margin: (BlInsets
				top: 3
				right: 10
				bottom: 10
				left: 10).
	^ tmp1
]

{ #category : #accessing }
GtPharoMethodExpanderAttribute >> classOrMetaClass [
	^ classOrMetaClass
]

{ #category : #accessing }
GtPharoMethodExpanderAttribute >> compiledMethod [
	^ classOrMetaClass lookupSelector: selector
]

{ #category : #private }
GtPharoMethodExpanderAttribute >> configureViewModel: arg1 andCoder: arg2 [
	| tmp1 tmp2 tmp3 |
	argumentBindingsBuilder ifNil: [ ^ self ].
	argumentBindingsBuilder
		compiledMethod: self compiledMethod;
		build.
	(tmp1 := argumentBindingsBuilder explicitProviderClass)
		ifNotNil: [ arg2 explicitProviderClass: tmp1 ].
	(tmp2 := argumentBindingsBuilder localBindings)
		ifNotNil: [ arg1 addLocalBindings: tmp2 ].
	(tmp3 := argumentBindingsBuilder receiverObject)
		ifNotNil: [ arg1 selfObject: tmp3 ]
]

{ #category : #'initialize-release' }
GtPharoMethodExpanderAttribute >> forClass: arg1 andSelector: arg2 [
	classOrMetaClass := arg1.
	selector := arg2
]

{ #category : #'initialize-release' }
GtPharoMethodExpanderAttribute >> initialize [
	super initialize.
	self
		attributesCreatingBlock: [ | tmp2 |
			tmp2 := BrTextAdornmentDynamicAttribute new.
			tmp2
				beAppend;
				stencil: [ self buildMethodCoder ] ]
]

{ #category : #printing }
GtPharoMethodExpanderAttribute >> printOn: arg1 [
	arg1
		nextPutAll: 'method-expander: ';
		print: self id
]

{ #category : #accessing }
GtPharoMethodExpanderAttribute >> selector [
	^ selector
]
