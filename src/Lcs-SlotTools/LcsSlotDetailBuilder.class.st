Class {
	#name : #LcsSlotDetailBuilder,
	#superclass : #LcsCodeBuilderStep,
	#instVars : [
		'targetClassName',
		'targetClass'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #'gt views' }
LcsSlotDetailBuilder >> gtPropertiesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Properties';
		items: [ self properties associations ];
		column: 'Property' text: #key;
		column: 'Value' text: #value;
		send: #value;
		actionUpdateButton
]

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
	^ self properties at: 'slotName' ifAbsent: [ nil ]
]

{ #category : #accessing }
LcsSlotDetailBuilder >> slotName: anObject [
	self properties at: 'slotName' put: anObject
]

{ #category : #accessing }
LcsSlotDetailBuilder >> targetClass [
	^ targetClass ifNil: [[ self targetClassName asString asClass ] 
			on: NotFound 
			do: [ :s | s return: nil ]]
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
	targetClassName := anObject.
	self targetClass: nil.
]
