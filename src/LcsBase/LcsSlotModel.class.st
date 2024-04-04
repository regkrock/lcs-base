Class {
	#name : #LcsSlotModel,
	#superclass : #LcsObject,
	#instVars : [
		'slotDefinitions',
		'parent'
	],
	#category : #LcsBase
}

{ #category : #initialization }
LcsSlotModel class >> newOn: aSystem [ 
	^ LcsSlotModel new
		parent: aSystem;
		yourself
]

{ #category : #accessing }
LcsSlotModel >> addSlotDefinitions: aSlotDefinitions [
	self slotDefinitions at: aSlotDefinitions parent put: aSlotDefinitions
]

{ #category : #accessing }
LcsSlotModel >> gtSlotModelFor: aView [
	<gtView>
	self slotDefinitions ifEmpty: [ ^ aView empty ].
	^ aView columnedTree 
		title: 'Slot Model';
		priority: 2.5;
		expandUpTo: 3;
		items: [ self gtViewSlotModelChildren ];
		children: [ :each | each value gtViewSlotModelChildren ];
		column: 'Key' translated
			text: [ :each | each key displayString ];
		column: 'Value' translated 
			text: [ :each | 
				(each value isKindOf: #LcsSlotDefinitions asClass)
					ifTrue: [ '' ]
					ifFalse: [ each value displayString ] ];				
		send: #value;
		yourself
]

{ #category : #accessing }
LcsSlotModel >> gtViewSlotModelChildren [
	^ self slotDefinitions associations  
]

{ #category : #accessing }
LcsSlotModel >> hasSlotDefinitions [
	^ self slotDefinitions notEmpty
]

{ #category : #accessing }
LcsSlotModel >> initialize [
	super initialize.
	self slotDefinitions: LcsSmalltalkConfiguration identityDictionaryClass new
]

{ #category : #initialization }
LcsSlotModel >> parent: aSystem [ 
	parent := aSystem
]

{ #category : #accessing }
LcsSlotModel >> restoreSlotDefinitions [
	self slotDefinitions keysAndValuesDo: [ :eachClass :eachSlotDefinitions | eachClass slotDefinitions: eachSlotDefinitions] 
]

{ #category : #accessing }
LcsSlotModel >> restoreSlotModel [
	#LcsDomainObject asClass releaseApplicationEnvironment.
	self slotDefinitions keysAndValuesDo: [ :eachKey :eachValue | eachKey slotDefinitions: eachValue ]

]

{ #category : #accessing }
LcsSlotModel >> slotDefinitions [
	^ slotDefinitions
]

{ #category : #accessing }
LcsSlotModel >> slotDefinitions: anObject [
	slotDefinitions := anObject
]
