Class {
	#name : #LcsSlotInstanceVariableBuilder,
	#superclass : #LcsSlotDetailBuilder,
	#category : #'Lcs-Tools'
}

{ #category : #building }
LcsSlotInstanceVariableBuilder >> installCode [
	self slotBuilder isInstanceVariableAlreadyCreated ifTrue: [ ^ self ].
	self refactoring: (RBAddInstanceVariableChange add: self  slotName to: self target).
	self refactoring execute
]

{ #category : #printing }
LcsSlotInstanceVariableBuilder >> jobStepActionDescription [
	^ 'Install instVar '
]

{ #category : #verification }
LcsSlotInstanceVariableBuilder >> verifyCodeInstallation [
	self assert: (self target allInstVarNames includes: self slotName).
]
