Class {
	#name : #LcsSlotInstanceVariableBuilder,
	#superclass : #LcsSlotDetailBuilder,
	#category : #'Lcs-Tools'
}

{ #category : #'gt views' }
LcsSlotInstanceVariableBuilder >> addRefactoringTextDetailsTo: aStream [
	([ self isInstanceVariableAlreadyCreated ] on: Error do: [ :s | false ])
		ifTrue: [ aStream nextPutAll: 'Use existing instanceVariable: ' , self slotName ]
		ifFalse: [ aStream nextPutAll: 'Add instanceVariable: ' , self slotName ]
]

{ #category : #'gt views' }
LcsSlotInstanceVariableBuilder >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView text
		title: 'Refactoring';
		priority: 1;
		text: [ self refactoringText asRopedText ]
]

{ #category : #building }
LcsSlotInstanceVariableBuilder >> installCode [
	self isInstanceVariableAlreadyCreated ifTrue: [ ^ self ].
	self refactoring: (RBAddInstanceVariableChange add: self slotName to: self target).
	self refactoring execute
]

{ #category : #'gt views' }
LcsSlotInstanceVariableBuilder >> isInstanceVariableAlreadyCreated [
	^ self slotBuilder isInstanceVariableAlreadyCreated
]

{ #category : #printing }
LcsSlotInstanceVariableBuilder >> jobStepActionDescription [
	^ 'Install instVar '
]

{ #category : #verification }
LcsSlotInstanceVariableBuilder >> verifyCodeInstallation [
	self assert: (self target allInstVarNames includes: self slotName).
]
