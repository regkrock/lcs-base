Class {
	#name : 'LcsChangedSlot',
	#superclass : 'LcsObject',
	#instVars : [
		'slotName',
		'newValue',
		'parent'
	],
	#category : 'Lcs-SystemManagement-UnitOfWork',
	#package : 'Lcs-SystemManagement',
	#tag : 'UnitOfWork'
}

{ #category : 'instance creation' }
LcsChangedSlot class >> newFor: aSlotName parent: aChangedObjectRecord [

	^self new
		initailzeFor: aSlotName parent: aChangedObjectRecord;
		yourself	
]

{ #category : 'api' }
LcsChangedSlot >> applyChangeRecordingHistoryIn: aChangeRecord [
	(aChangeRecord changes newSlotChangeRecord: self slotName)
		newValue: self newValue.
	self domainObject instVarNamed: self slotName asString put: self newValue
]

{ #category : 'api' }
LcsChangedSlot >> domainObject [
	^ self parent domainObject
]

{ #category : 'gt views' }
LcsChangedSlot >> gtUnitOfWorkChildren [
	^ LcsUnitOfWorkViewItem newLabel: self slotName item: self newValue
]

{ #category : 'initialize' }
LcsChangedSlot >> initailzeFor: aSlotName parent: aChangedObjectRecord [ 
	self
		slotName: aSlotName;
		parent: aChangedObjectRecord
]

{ #category : 'accessing' }
LcsChangedSlot >> newValue [
	^ newValue
]

{ #category : 'accessing' }
LcsChangedSlot >> newValue: anObject [
	newValue := anObject
]

{ #category : 'accessing' }
LcsChangedSlot >> parent [
	^ parent
]

{ #category : 'accessing' }
LcsChangedSlot >> parent: anObject [
	parent := anObject
]

{ #category : 'accessing' }
LcsChangedSlot >> slotName [
	^ slotName
]

{ #category : 'accessing' }
LcsChangedSlot >> slotName: anObject [
	slotName := anObject
]
