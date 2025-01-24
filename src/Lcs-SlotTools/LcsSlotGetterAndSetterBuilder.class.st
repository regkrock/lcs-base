Class {
	#name : #LcsSlotGetterAndSetterBuilder,
	#superclass : #LcsSlotDetailBuilder,
	#category : #'Lcs-SlotTools'
}

{ #category : #printing }
LcsSlotGetterAndSetterBuilder >> addRefactoringTextDetailsTo: aStream [
	self slotName isNil ifTrue: [
		aStream nextPutAll: '<missing> slot name - no getter and setter will be implemented'.
		^self].
	self isAlreadyImplementedInTargetClass
		ifTrue: [ 
			aStream 
				nextPutAll: (self slotName ifNil: [ '<missing>' ]);
				nextPutAll: ' getter and setter are already implemented in ';
				nextPutAll: self target name displayString.
			^self].
	self isAlreadyImplementedInSuperclass
		ifTrue: [
			aStream 
				nextPutAll:  self slotName asString;
				nextPutAll: ' getter and setter are already implemented in superclass'.
			^self ].
	^ aStream
		nextPutAll: self protoGetterAndSetterRefactoring slotSetterMethodSource;
		cr;
		cr;
		nextPutAll: self protoGetterAndSetterRefactoring slotGetterMethodSource
]

{ #category : #'gt view' }
LcsSlotGetterAndSetterBuilder >> getterAndSetterMethodsFilter [
	| classFilter |
	classFilter := (GtSearchInheritedMethodsFilter forClass: self target)
			withSuperclassesUpTo: #LcsDomainObject asClass.
	^ classFilter & (self getterSelector gtImplementors | self setterSelector gtImplementors)
]

{ #category : #selector }
LcsSlotGetterAndSetterBuilder >> getterSelector [
	^ self slotName asString asSymbol
]

{ #category : #'gt view' }
LcsSlotGetterAndSetterBuilder >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView text
		title: 'Refactoring';
		priority: 1;
		text: [ self refactoringText asRopedText ]
]

{ #category : #'gt view' }
LcsSlotGetterAndSetterBuilder >> gtSlotAccessorImplementorsFor: aView [
	<gtView>
	self target isNil ifTrue: [ ^ aView empty ].
	^ aView explicit
		title: 'Implementor(Slot Accessors)';
		priority: 200;
		stencil: [ self getterAndSetterMethodsFilter ]
]

{ #category : #command }
LcsSlotGetterAndSetterBuilder >> installCode [
	self isAlreadyImplementedInSuperclass ifTrue: [ ^ self ].
	self addRefactoring: (
		RBCreateDomainSlotAcccessorsForVariableRefactoring
			instanceVariable: self slotName
			class: self target) execute.
	self beCodeInstalled
]

{ #category : #testing }
LcsSlotGetterAndSetterBuilder >> isAlreadyImplementedInSuperclass [
	self _target isNil ifTrue: [ ^ false ].
	^ self target superclass canUnderstand: self getterSelector
]

{ #category : #testing }
LcsSlotGetterAndSetterBuilder >> isAlreadyImplementedInTargetClass [
	self _target isNil ifTrue: [ ^ false ].
	^ self target canUnderstand: self slotName asSymbol
]

{ #category : #printing }
LcsSlotGetterAndSetterBuilder >> jobStepActionDescription [
	^ 'Install getter and setter for'
]

{ #category : #building }
LcsSlotGetterAndSetterBuilder >> protoGetterAndSetterRefactoring [
	^ RBCreateDomainSlotAcccessorsForVariableRefactoring
		instanceVariable: self slotName
		class: ([ self target ] on: Error do: [ :s | s return: #UndefinedClass asClass ] )
]

{ #category : #selector }
LcsSlotGetterAndSetterBuilder >> setterSelector [
	^ (self slotName asString , ':') asSymbol
]

{ #category : #accessing }
LcsSlotGetterAndSetterBuilder >> targetClassName [
	^ self parent targetClassName
]

{ #category : #command }
LcsSlotGetterAndSetterBuilder >> verifyCodeInstallation [
	self assert: (self target canUnderstand: self getterSelector).
	self assert: (self target canUnderstand: self setterSelector).
]
