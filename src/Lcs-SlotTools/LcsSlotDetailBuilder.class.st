Class {
	#name : #LcsSlotDetailBuilder,
	#superclass : #LcsCodeBuilderStep,
	#instVars : [
		'targetClassName',
		'targetClass'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #printing }
LcsSlotDetailBuilder >> derivedSlotName [
	^ self slotName ifNil: ['<missing slotName>']
]

{ #category : #'as yet unclassified' }
LcsSlotDetailBuilder >> gtClassViewOn: aView [
	<gtView>
	self targetClass isNil ifTrue: [ 
		^ aView list
			title: self targetClassName;
			priority: 200;
			items: [ {'Not yet created'} ];
			actionUpdateButton;
			yourself ].
	^ aView explicit
		title: 'Installed(' , self targetClass name , ')';
		priority: 200;
		stencil: [ (GtCoderElement forObject: self targetClass) disablePlayPage beNormalLevel ];
		actionUpdateButton;
		yourself
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
		nextPutAll: self derivedSlotName;
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
