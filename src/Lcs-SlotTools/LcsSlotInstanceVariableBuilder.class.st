Class {
	#name : 'LcsSlotInstanceVariableBuilder',
	#superclass : 'LcsSlotDetailBuilder',
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'command' }
LcsSlotInstanceVariableBuilder >> _installCode [
	super _installCode.
	self assert: self rawDerivedSlotName notNil.
	self isInstanceVariableAlreadyCreated ifTrue: [ ^ self ].
	self addRefactoring: (RBAddInstanceVariableChange add: self derivedSlotName to: self targetClass) execute.
	self beCodeInstalled
]

{ #category : 'command' }
LcsSlotInstanceVariableBuilder >> _verifyCodeInstallation [
	super _verifyCodeInstallation.
	self assert: (self targetClass allInstVarNames includes: self slotName).
]

{ #category : 'gt views' }
LcsSlotInstanceVariableBuilder >> addClassesToUmlModel: umlModel [ 
	super addClassesToUmlModel: umlModel
]

{ #category : 'gt views' }
LcsSlotInstanceVariableBuilder >> addRefactoringTextDetailsTo: aStream [
	aStream nextPutAll: self targetClassName.
	([ self isInstanceVariableAlreadyCreated ] on: Error do: [ :s | false ])
		ifTrue: [ aStream nextPutAll: ' - using existing instanceVariable: ' , self slotName ]
		ifFalse: [ 
			aStream 
				nextPutAll: ' - add instanceVariable: ';
				nextPutAll:  self derivedSlotName ]
]

{ #category : 'gt views' }
LcsSlotInstanceVariableBuilder >> gtRefactoringChangeOn: aView [
	<gtView>
	^ (super gtRefactoringChangeOn: aView)
		priority: 1
		yourself
]

{ #category : 'gt views' }
LcsSlotInstanceVariableBuilder >> isInstanceVariableAlreadyCreated [
	^ self targetClass allInstVarNames includes: self derivedSlotName
]

{ #category : 'printing' }
LcsSlotInstanceVariableBuilder >> jobStepActionDescription [
	^ 'Install instVar '
]

{ #category : 'command' }
LcsSlotInstanceVariableBuilder >> uninstall [
	super uninstall.
	self targetClass ifNotNil: [ self targetClass removeInstVar: self slotName ]
]

{ #category : 'command' }
LcsSlotInstanceVariableBuilder >> verifyUninstall [
	super verifyUninstall.
	self targetClass isNil ifTrue: [ ^ self  ].
	self slotName isNil ifTrue: [ ^ self ].
	self assert: (self targetClass instVarNames includes: self slotName asSymbol) not.
]
