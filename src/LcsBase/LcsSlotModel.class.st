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
