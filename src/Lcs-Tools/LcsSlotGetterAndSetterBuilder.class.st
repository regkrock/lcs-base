Class {
	#name : #LcsSlotGetterAndSetterBuilder,
	#superclass : #LcsSlotDetailBuilder,
	#category : #'Lcs-Tools'
}

{ #category : #printing }
LcsSlotGetterAndSetterBuilder >> addRefactoringTextDetailsTo: aStream [
	self isAlreadyImplementedInTargetClass
		ifTrue: [ 
			aStream 
				nextPutAll: self slotName asString;
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

{ #category : #'gt views' }
LcsSlotGetterAndSetterBuilder >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView text
		title: 'Refactoring';
		priority: 1;
		text: [ self refactoringText asRopedText ]
]

{ #category : #building }
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
	self _target isNil ifTrue: [ ^ true ].
	^ self target superclass canUnderstand: self slotName asSymbol
]

{ #category : #'gt views' }
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
		class: ([ self target ] on: Error do: [ :s | UndefinedClass ] )
]

{ #category : #'as yet unclassified' }
LcsSlotGetterAndSetterBuilder >> targetClassName [
	^ self parent targetClassName
]

{ #category : #verification }
LcsSlotGetterAndSetterBuilder >> verifyCodeInstallation [
	self assert: (self target canUnderstand: self slotName asSymbol).
	self assert: (self target canUnderstand: (self slotName , ':') asSymbol).
]
