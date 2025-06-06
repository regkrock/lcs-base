Class {
	#name : #LcsAuthor,
	#superclass : #LcsDomainObject,
	#instVars : [
		'authorship',
		'person'
	],
	#category : #'Lcs-WarRabbitLibrary'
}

{ #category : #'slot definitions' }
LcsAuthor class >> authorshipSlotDefinition [
	<slotDefinition>
	^ LcsSecondaryCollectionSlot new
		slotName: 'authorship';
		addCollectionMemberType: LcsLibraryItem;
		addSlotType: LcsLibraryItems; 
		yourself
]

{ #category : #'slot definitions' }
LcsAuthor class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotName: 'authors';
		collectionSlotModuleName: LcsWarRabbitLibrary defaultModuleName;
		addSlotType: LcsAuthors
		yourself
]

{ #category : #'slot definitions' }
LcsAuthor class >> personSlotDefinition [
	<slotDefinition>
	^ LcsMemberOfSlot new
		slotName: 'person';
		collectionSlotName: 'persons';
		collectionSlotModuleName: LcsLegalEntitiesModule defaultModuleName;
		initialValueBlock: [ :domainParent :slotDefinition | slotDefinition targetCollection unknown ];
		addSlotType: LcsBasePerson;
		yourself
]

{ #category : #accessing }
LcsAuthor >> authorship [
	^ self slotVarNamed: 'authorship'
]

{ #category : #accessing }
LcsAuthor >> authorship: anObject [
	self slotVarNamed: 'authorship' put: anObject
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
	^ self slotVarNamed: 'person'
]

{ #category : #accessing }
LcsAuthor >> person: anObject [
	self slotVarNamed: 'person' put: anObject
]

{ #category : #person }
LcsAuthor >> surname [
	^ self person surname
]
