Class {
	#name : #LcsLibraryItem,
	#superclass : #LcsDomainObject,
	#instVars : [
		'libraryCategory',
		'itemName',
		'itemAuthors'
	],
	#classInstVars : [
		'collectionSlotName'
	],
	#category : #'Lcs-WarRabbitLibrary'
}

{ #category : #'slot definitions' }
LcsLibraryItem class >> authorsSlotDefinition [
	"<slotDefinition>"
	^LcsSecondaryCollectionSlot new
		slotName: 'authors';
		addSlotType: LcsAuthors; 
		addCollectionMemberType: LcsAuthor;
		beOrderedCollection;
		yourself
]

{ #category : #'slot definitions' }
LcsLibraryItem class >> collectionSlotName [
	^ collectionSlotName
]

{ #category : #'slot definitions' }
LcsLibraryItem class >> itemAuthorsSlotDefinition [
	<slotDefinition>
	^LcsSecondaryCollectionSlot new
		slotName: 'itemAuthors';
		addSlotType: LcsItemAuthors; 
		addCollectionMemberType: LcsAuthor;
		beOrderedCollection;
		yourself
]

{ #category : #'slot definitions' }
LcsLibraryItem class >> itemNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'itemName';
		beRequired;
		yourself
]

{ #category : #'slot definitions' }
LcsLibraryItem class >> libraryCategorySlotDefinition [
	<slotDefinition>
	^ LcsMemberOfSlot new
		slotName: 'libraryCategory';
		collectionSlotName: 'libraryCategories';
		collectionSlotModuleName: 'WarRabbitLibrary';
		beRequired;
		yourself
]

{ #category : #'slot definitions' }
LcsLibraryItem class >> librearyCategorySlotDefinition [
	<slotDefinition>
	^ LcsMemberOfSlot new
		slotName: 'libraryCategory';
		collectionSlotName: 'libraryCategories';
		collectionSlotModuleName: 'WarRabbitLibrary';
		beRequired;
		yourself
]

{ #category : #'instance creation' }
LcsLibraryItem class >> newFor: line [ 
]

{ #category : #accessing }
LcsLibraryItem class >> newOn: aString parts: protoItemParts [ 
	^ self new
		initializeOn: aString parts: protoItemParts;
		yourself
]

{ #category : #'slot definitions' }
LcsLibraryItem class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotModuleName: LcsWarRabbitLibrary defaultModuleName;
		collectionSlotName: 'libraryItems';
		yourself
]

{ #category : #accessing }
LcsLibraryItem >> initializeOn: aString parts: protoItemParts [ 
	self 
		"originalLine: aString;
		parts: protoItemParts"
]

{ #category : #accessing }
LcsLibraryItem >> itemAuthors [
	^ self slotVarNamed: 'itemAuthors'
]

{ #category : #accessing }
LcsLibraryItem >> itemAuthors: anObject [
	self slotVarNamed: 'itemAuthors' put: anObject
]

{ #category : #accessing }
LcsLibraryItem >> itemName [
	^ self slotVarNamed: 'itemName'
]

{ #category : #accessing }
LcsLibraryItem >> itemName: anObject [
	self slotVarNamed: 'itemName' put: anObject
]

{ #category : #accessing }
LcsLibraryItem >> libraryCategory [
	^ self slotVarNamed: 'libraryCategory'
]

{ #category : #accessing }
LcsLibraryItem >> libraryCategory: anObject [
	self slotVarNamed: 'libraryCategory' put: anObject
]
