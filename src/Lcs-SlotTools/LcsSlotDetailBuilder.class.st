Class {
	#name : #LcsSlotDetailBuilder,
	#superclass : #LcsCodeBuilderStep,
	#instVars : [
		'refactoring',
		'slotName',
		'targetClassName',
		'targetClass'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #printing }
LcsSlotDetailBuilder >> jobStepActionDescription [
	self subclassResponsibility
]

{ #category : #printing }
LcsSlotDetailBuilder >> printJobStreamDetailsOn: aStream [
	aStream
		nextPutAll: self jobStepActionDescription;
		nextPutAll: ' "';
		nextPutAll: (self slotName ifNil: [ '<missing slotName>' ]);
		nextPutAll: '" in ';
		nextPutAll: (self targetClassName ifNil: [ '<missing target class name>' ])
]

{ #category : #building }
LcsSlotDetailBuilder >> slotBuilder [
	^ self parent parent
]

{ #category : #building }
LcsSlotDetailBuilder >> slotDefinitionSource [
	^ self slotBuilder slotDefinitionSource
]

{ #category : #accessing }
LcsSlotDetailBuilder >> slotName [
	^ slotName
]

{ #category : #accessing }
LcsSlotDetailBuilder >> slotName: anObject [
	slotName := anObject
]

{ #category : #printing }
LcsSlotDetailBuilder >> stepNumber [
	| stepNumber  |
	stepNumber := self parent 
					ifNil: [ '1'] 
					ifNotNil: [ (self parent indexOf: self) printString ].
	^ self slotBuilder addStepNumberTo: stepNumber.
]

{ #category : #accessing }
LcsSlotDetailBuilder >> targetClass [
	^ [ self targetClassName asString asClass ] 
			on: NotFound 
			do: [ :s | s return: nil ]
]

{ #category : #accessing }
LcsSlotDetailBuilder >> targetClass: anObject [
	targetClass := anObject
]

{ #category : #accessing }
LcsSlotDetailBuilder >> targetClassName [
	^ targetClassName
]

{ #category : #accessing }
LcsSlotDetailBuilder >> targetClassName: anObject [
	targetClassName := anObject
]

{ #category : #verification }
LcsSlotDetailBuilder >> verifyCodeInstallation [
]
