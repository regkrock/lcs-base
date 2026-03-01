Class {
	#name : 'LcsSlotDetailBuilder',
	#superclass : 'LcsCodeBuilderStep',
	#instVars : [
		'targetClassName',
		'targetClass',
		'slotTemplate',
		'slotClass'
	],
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'printing' }
LcsSlotDetailBuilder >> derivedSlotName [
		^ self rawDerivedSlotName ifNil: [ '<missing slotName>' ]
]

{ #category : 'gt views' }
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

{ #category : 'printing' }
LcsSlotDetailBuilder >> jobStepActionDescription [
	self subclassResponsibility
]

{ #category : 'printing' }
LcsSlotDetailBuilder >> printJobStreamDetailsOn: aStream [
	aStream
		nextPutAll: self jobStepActionDescription;
		nextPutAll: ' "';
		nextPutAll: self derivedSlotName;
		nextPutAll: '" in ';
		nextPutAll: (self targetClassName ifNil: [ '<missing target class name>' ])
]

{ #category : 'gt views' }
LcsSlotDetailBuilder >> rawDerivedSlotName [
	self slotName ifNotNil: [ ^ self slotName ].
	^ self slotTemplateSlotName
]

{ #category : 'building' }
LcsSlotDetailBuilder >> slotBuilder [
	^ self parent parent
]

{ #category : 'accessing' }
LcsSlotDetailBuilder >> slotClass [
	^ slotClass
]

{ #category : 'accessing' }
LcsSlotDetailBuilder >> slotClass: anObject [
	slotClass := anObject
]

{ #category : 'building' }
LcsSlotDetailBuilder >> slotDefinitionSource [
	^ self slotBuilder slotDefinitionSource
]

{ #category : 'accessing' }
LcsSlotDetailBuilder >> slotName [
	^ self properties at: 'slotName' ifAbsent: [ nil ]
]

{ #category : 'accessing' }
LcsSlotDetailBuilder >> slotName: anObject [
	self properties at: 'slotName' put: anObject
]

{ #category : 'accessing' }
LcsSlotDetailBuilder >> slotTemplate [
	^ slotTemplate ifNil: [ 
		self slotClass ifNil: [ ^ nil ].
		slotTemplate := self slotClass new ]
]

{ #category : 'accessing' }
LcsSlotDetailBuilder >> slotTemplate: anObject [
	slotTemplate := anObject
]

{ #category : 'accessing' }
LcsSlotDetailBuilder >> slotTemplateSlotName [
	self slotTemplate ifNil: [ ^ nil ].
	^ self slotTemplate slotName
]

{ #category : 'accessing' }
LcsSlotDetailBuilder >> targetClass [
	^ targetClass ifNil: [[ self targetClassName asString asClass ] 
			on: NotFound 
			do: [ :s | s return: nil ]]
]

{ #category : 'accessing' }
LcsSlotDetailBuilder >> targetClass: anObject [
	targetClass := anObject.
	targetClassName := anObject isClass ifTrue: [ anObject name ] ifFalse: [ nil ]
]

{ #category : 'accessing' }
LcsSlotDetailBuilder >> targetClassName [
	^ targetClassName
]

{ #category : 'accessing' }
LcsSlotDetailBuilder >> targetClassName: anObject [
	targetClassName := anObject.
	targetClass := nil.
]
