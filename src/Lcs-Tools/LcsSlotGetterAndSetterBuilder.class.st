Class {
	#name : #LcsSlotGetterAndSetterBuilder,
	#superclass : #LcsSlotDetailBuilder,
	#category : #'Lcs-Tools'
}

{ #category : #building }
LcsSlotGetterAndSetterBuilder >> installCode [
	self refactoring: (
		RBCreateDomainSlotAcccessorsForVariableRefactoring
			instanceVariable: self slotName
			class: self target).
	self refactoring execute
]

{ #category : #printing }
LcsSlotGetterAndSetterBuilder >> jobStepActionDescription [
	^ 'Install getter and setter for'
]

{ #category : #verification }
LcsSlotGetterAndSetterBuilder >> verifyCodeInstallation [
	self assert: (self target canUnderstand: self slotName asSymbol).
	self assert: (self target canUnderstand: (self slotName , ':') asSymbol).
]
