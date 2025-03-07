Class {
	#name : #LcsChangedObjectRecord,
	#superclass : #LcsObjectChangeRecord,
	#instVars : [
		'changedSlots'
	],
	#category : #'Lcs-SystemManagement-UnitOfWork'
}

{ #category : #api }
LcsChangedObjectRecord >> applyChanges [

	self changedSlots do: [ :each | each applyChange ].
	self domainObject isSupportDomainObject ifFalse: [
		self domainObject version: self domainObject version + 1 .
		self domainObject "history" ].
]

{ #category : #api }
LcsChangedObjectRecord >> changedSlot: aSlotName valueTo: anObject [

	(self changedSlots at: aSlotName ifAbsentPut: [ LcsChangedSlot newFor: aSlotName parent: self ]) 
		newValue: anObject
]

{ #category : #api }
LcsChangedObjectRecord >> changedSlotRecordFor: aSlotName [
	^ self changedSlots at: aSlotName ifAbsent: [ nil ]
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
LcsChangedObjectRecord >> gtUnitOfWorkChildren [
	^ LcsUnitOfWorkViewItem newLabel: self domainObject item: self changedSlots values
]

{ #category : #initialize }
LcsChangedObjectRecord >> initialize [

	super initialize.
	self changedSlots: LcsSmalltalkConfiguration symbolDictionaryClass new
]

{ #category : #api }
LcsChangedObjectRecord >> valueOfSlot: aSlotName [
	^ (self changedSlots at: aSlotName ifAbsent: [ nil ]) newValue
]

{ #category : #accessing }
LcsChangedObjectRecord >> viewItemLabel [
	^ 'Changed'
]
