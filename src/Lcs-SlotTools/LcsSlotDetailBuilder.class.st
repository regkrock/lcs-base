Class {
	#name : #LcsSlotDetailBuilder,
	#superclass : #LcsCodeBuilderStep,
	#instVars : [
		'refactoring'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #building }
LcsSlotDetailBuilder >> _target [
	^ self slotBuilder _target
]

{ #category : #printing }
LcsSlotDetailBuilder >> jobStepActionDescription [
	^ 'Install instVar'
]

{ #category : #printing }
LcsSlotDetailBuilder >> printJobStreamDetailsOn: aStream [
	aStream
		nextPutAll: self jobStepActionDescription;
		nextPutAll: ' "';
		nextPutAll: (self slotName ifNil: [ '<missing>' ]);
		nextPutAll: '" in ';
		nextPutAll: self slotBuilder targetClassName
]

{ #category : #building }
LcsSlotDetailBuilder >> slotBuilder [
	^ self parent parent
]

{ #category : #building }
LcsSlotDetailBuilder >> slotDefinitionSource [
	^ self slotBuilder slotDefinitionSource
]

{ #category : #building }
LcsSlotDetailBuilder >> slotName [
	^ self slotBuilder slotName
]

{ #category : #printing }
LcsSlotDetailBuilder >> stepNumber [
	| stepNumber  |
	stepNumber := self parent 
					ifNil: [ '1'] 
					ifNotNil: [ (self parent indexOf: self) printString ].
	^ self slotBuilder addStepNumberTo: stepNumber.
]

{ #category : #building }
LcsSlotDetailBuilder >> target [
	^ self slotBuilder target
]

{ #category : #verification }
LcsSlotDetailBuilder >> verifyCodeInstallation [
]

{ #category : #verification }
LcsSlotDetailBuilder >> verifySlotModelUpdatesMadeByBuilder [
]
