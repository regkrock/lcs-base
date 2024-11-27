Class {
	#name : #LcsSlotGetterAndSetterBuilder,
	#superclass : #LcsSlotDetailBuilder,
	#category : #'Lcs-Tools'
}

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
	self
		refactoring: (RBCreateDomainSlotAcccessorsForVariableRefactoring
				instanceVariable: self slotName
				class: self target).
	self refactoring execute
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

{ #category : #'gt views' }
LcsSlotGetterAndSetterBuilder >> refactoringText [
	self isAlreadyImplementedInTargetClass
		ifTrue: [ ^ self slotName asString , ' getter and setter are already implemented in '
				, self target name displayString ].
	self isAlreadyImplementedInSuperclass
		ifTrue: [ ^ self slotName asString
				, ' getter and setter are already implemented in superclass' ].
	^ (WriteStream on: String new)
		nextPutAll: self protoGetterAndSetterRefactoring slotSetterMethodSource;
		cr;
		cr;
		nextPutAll: self protoGetterAndSetterRefactoring slotGetterMethodSource;
		contents
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
