Class {
	#name : #LcsAuthor,
	#superclass : #LcsDomainObject,
	#instVars : [
		'authorship',
		'person'
	],
	#category : #'Lcs-WarRabbitLibrary'
}

{ #category : #'slot definition' }
LcsAuthor class >> authorshipSlotDefinition [
	<slotDefinition>
	^ LcsSecondaryCollectionSlot new
		slotName: 'authorship';
		addCollectionMemberType: LcsLibraryItem;
		addSlotType: LcsLibraryItems; 
		yourself
]

{ #category : #'slot definition' }
LcsAuthor class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotName: 'authors';
		collectionSlotModuleName: LcsWarRabbitLibrary moduleName;
		addSlotType: LcsAuthor
		yourself
]

{ #category : #'slot definition' }
LcsAuthor class >> personSlotDefinition [
	<slotDefinition>
	^ LcsMemberOfSlot new
		slotName: 'person';
		collectionSlotName: 'persons';
		collectionSlotModuleName: LcsLegalEntitiesModule moduleName;
		yourself
]

{ #category : #accessing }
LcsAuthor >> authorship [
	^ self getValueOfSlotNamed: 'authorship'
]

{ #category : #accessing }
LcsAuthor >> authorship: anObject [
	self setValueOfSlotNamed: 'authorship' to: anObject
]

{ #category : #person }
LcsAuthor >> firstName [
	^ self person firstName
]

{ #category : #person }
LcsAuthor >> middleNames [
	^ self person middleNames
]

{ #category : #accessing }
LcsAuthor >> person [
	^ self getValueOfSlotNamed: 'person'
]

{ #category : #accessing }
LcsAuthor >> person: anObject [
	self setValueOfSlotNamed: 'person' to: anObject
]

{ #category : #person }
LcsAuthor >> surname [
	^ self person surname
]
