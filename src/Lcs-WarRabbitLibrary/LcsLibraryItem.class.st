Class {
	#name : #LcsLibraryItem,
	#superclass : #LcsDomainObject,
	#instVars : [
		'libraryCategory',
		'itemName',
		'itemAuthors'
	],
	#category : #'Lcs-WarRabbitLibrary'
}

{ #category : #'slot definition' }
LcsLibraryItem class >> authorsSlotDefinition [
	<slotDefinition>
	^LcsSecondaryCollectionSlot new
		slotName: 'authors';
		addSlotType: LcsAuthors; 
		addCollectionMemberType: LcsAuthor;
		beOrderedCollection;
		yourself
]

{ #category : #'slot definition' }
LcsLibraryItem class >> itemAuthorsSlotDefinition [
	<slotDefinition>
	^LcsSecondaryCollectionSlot new
		slotName: 'itemAuthors';
		addSlotType: LcsItemAuthors; 
		addCollectionMemberType: LcsAuthor;
		beOrderedCollection;
		yourself
]

{ #category : #'slot definition' }
LcsLibraryItem class >> itemNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'itemName';
		beRequired;
		yourself
]

{ #category : #'slot definition' }
LcsLibraryItem class >> librearyCategorySlotDefinition [
	<slotDefinition>
	^ LcsMemberOfSlot new
		slotName: 'libraryCategory';
		beRequired;
		yourself
]

{ #category : #'instance  creation' }
LcsLibraryItem class >> newFor: line [ 
]

{ #category : #'slot definition' }
LcsLibraryItem class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		moduleName: LcsWarRabbitLibrary moduleName;
		collectionSlotName: 'libraryItems';
		yourself
]

{ #category : #accessing }
LcsLibraryItem >> itemAuthors [
	^ self getValueOfSlotNamed: 'itemAuthors'
]

{ #category : #accessing }
LcsLibraryItem >> itemAuthors: anObject [
	self setValueOfSlotNamed: 'itemAuthors' to: anObject
]

{ #category : #accessing }
LcsLibraryItem >> itemName [
	^ self getValueOfSlotNamed: 'itemName'
]

{ #category : #accessing }
LcsLibraryItem >> itemName: anObject [
	self setValueOfSlotNamed: 'itemName' to: anObject
]

{ #category : #accessing }
LcsLibraryItem >> libraryCategory [
	^ self getValueOfSlotNamed: 'libraryCategory'
]

{ #category : #accessing }
LcsLibraryItem >> libraryCategory: anObject [
	self setValueOfSlotNamed: 'libraryCategory' to: anObject
]
