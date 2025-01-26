Class {
	#name : #LcsSlotInstanceVariableBuilder,
	#superclass : #LcsSlotDetailBuilder,
	#category : #'Lcs-SlotTools'
}

{ #category : #'gt views' }
LcsSlotInstanceVariableBuilder >> addRefactoringTextDetailsTo: aStream [
	([ self isInstanceVariableAlreadyCreated ] on: Error do: [ :s | false ])
		ifTrue: [ aStream nextPutAll: 'Use existing instanceVariable: ' , self slotName ]
		ifFalse: [ 
			aStream 
				nextPutAll: 'Add instanceVariable: ';
				nextPutAll:  (self slotName ifNil: [ '<missing>' ]) ]
]

{ #category : #'gt views' }
LcsSlotInstanceVariableBuilder >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView text
		title: 'Refactoring';
		priority: 1;
		text: [ self refactoringText asRopedText ]
]

{ #category : #command }
LcsSlotInstanceVariableBuilder >> installCode [
	self isInstanceVariableAlreadyCreated ifTrue: [ ^ self ].
	self addRefactoring: (RBAddInstanceVariableChange add: self slotName to: self target) execute.
	self beCodeInstalled
]

{ #category : #'gt views' }
LcsSlotInstanceVariableBuilder >> isInstanceVariableAlreadyCreated [
	^ self slotBuilder isInstanceVariableAlreadyCreated
]

{ #category : #printing }
LcsSlotInstanceVariableBuilder >> jobStepActionDescription [
	^ 'Install instVar '
]

{ #category : #command }
LcsSlotInstanceVariableBuilder >> verifyCodeInstallation [
	self assert: (self target allInstVarNames includes: self slotName).
]

{ #category : #command }
LcsSlotInstanceVariableBuilder >> verifyUninstall [
	([ self target ] on: NotFound do: [ :s | s return: nil ]) isNil ifTrue: [ ^ self  ].
	self assert: (self target allInstVarNames includes: self slotName) not.
]
