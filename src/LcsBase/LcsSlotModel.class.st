Class {
	#name : #LcsSlotModel,
	#superclass : #LcsObject,
	#instVars : [
		'slotDefintions',
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
	self slotDefintions at: aSlotDefinitions parent put: aSlotDefinitions
]

{ #category : #accessing }
LcsSlotModel >> initialize [
	super initialize.
	self slotDefintions: LcsSmalltalkConfiguration identityDictionaryClass new
]

{ #category : #initialization }
LcsSlotModel >> parent: aSystem [ 
	parent := aSystem
]

{ #category : #accessing }
LcsSlotModel >> restoreSlotDefinitions [
	self slotDefintions keysAndValuesDo: [ :eachClass :eachSlotDefinitions | eachClass slotDefinitions: eachSlotDefinitions]
]

{ #category : #accessing }
LcsSlotModel >> slotDefintions [
	^ slotDefintions
]

{ #category : #accessing }
LcsSlotModel >> slotDefintions: anObject [
	slotDefintions := anObject
]
