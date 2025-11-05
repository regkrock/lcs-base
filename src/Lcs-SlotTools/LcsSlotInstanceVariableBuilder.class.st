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
				nextPutAll:  self derivedSlotName ]
]

{ #category : #'gt views' }
LcsSlotInstanceVariableBuilder >> gtRefactoringChangeOn: aView [
	<gtView>
	^ (super gtRefactoringChangeOn: aView)
		priority: 1
		yourself
]

{ #category : #command }
LcsSlotInstanceVariableBuilder >> installCode [
	super installCode.
	self isInstanceVariableAlreadyCreated ifTrue: [ ^ self ].
	self addRefactoring: (RBAddInstanceVariableChange add: self slotName to: self targetClass) execute.
	self beCodeInstalled
]

{ #category : #'gt views' }
LcsSlotInstanceVariableBuilder >> isInstanceVariableAlreadyCreated [
	^ self targetClass allInstVarNames includes: self slotName
]

{ #category : #printing }
LcsSlotInstanceVariableBuilder >> jobStepActionDescription [
	^ 'Install instVar '
]

{ #category : #command }
LcsSlotInstanceVariableBuilder >> uninstall [
	super uninstall.
	self targetClass ifNotNil: [ self targetClass removeInstVar: self slotName ]
]

{ #category : #command }
LcsSlotInstanceVariableBuilder >> verifyCodeInstallation [
	super verifyCodeInstallation.
	self assert: (self targetClass allInstVarNames includes: self slotName).
]

{ #category : #command }
LcsSlotInstanceVariableBuilder >> verifyUninstall [
	super verifyUninstall.
	self targetClass isNil ifTrue: [ ^ self  ].
	self assert: (self targetClass instVarNames includes: self slotName asSymbol) not.
]
