Class {
	#name : #LcsChangedObjectRecord,
	#superclass : #LcsObjectChangeRecord,
	#instVars : [
		'changedSlots'
	],
	#category : #'Lcs-UnitOfWOrk'
}

{ #category : #ap }
LcsChangedObjectRecord >> applyChanges [

	self changedSlots do: [:each | each applyChange]
]

{ #category : #accessing }
LcsChangedObjectRecord >> changedSlot: aSlotName valueTo: anObject [

	(self changedSlots at: aSlotName ifAbsentPut: [LcsChangedSlot newFor: aSlotName parent: self]) 
		newValue: anObject
]

{ #category : #accessing }
LcsChangedObjectRecord >> changedSlots [
	^ changedSlots
]

{ #category : #accessing }
LcsChangedObjectRecord >> changedSlots: anObject [
	changedSlots := anObject
]

{ #category : #accessing }
LcsChangedObjectRecord >> initialize [

	super initialize.
	self changedSlots: LcsSmalltalkConfiguration symbolDictionaryClass new
]
