Class {
	#name : #LcsWarRabbitLibrary,
	#superclass : #LcsSystem,
	#instVars : [
		'libraryCategories',
		'libraryItems',
		'authors'
	],
	#category : #'Lcs-WarRabbitLibrary'
}

{ #category : #'slot definitions' }
LcsWarRabbitLibrary class >> authorsSlotDefinition [
	<slotDefinition>
	^LcsGlobalCollectionSlot new
		slotName: 'authors';
		addSlotType: LcsAuthors; 
		addCollectionMemberType: LcsAuthor;
		yourself
]

{ #category : #'slot definitions' }
LcsWarRabbitLibrary class >> configurationSlotDefinition [
	<slotDefinition>
	^ super configurationSlotDefinition
]

{ #category : #configuration }
LcsWarRabbitLibrary class >> defaultModuleName [
	^ 'War Rabbit System'
]

{ #category : #'slot definitions' }
LcsWarRabbitLibrary class >> libraryCategoriesSlotDefinition [
	<slotDefinition>
	^LcsGlobalCollectionSlot new
		slotName: 'libraryCategories';
		addSlotType: LcsLibraryCategories; 
		addCollectionMemberType: LcsLibraryCategory;
		yourself
]

{ #category : #'slot definitions' }
LcsWarRabbitLibrary class >> libraryItemsSlotDefinition [
	<slotDefinition>
	^LcsGlobalCollectionSlot new
		slotName: 'libraryItems';
		addSlotType: LcsLibraryItems; 
		addCollectionMemberType: LcsLibraryItem;
		yourself
]

{ #category : #'slot definitions' }
LcsWarRabbitLibrary class >> moduleConfigurationClass [
	^ LcsWarRabbitConfiguration
]

{ #category : #accessing }
LcsWarRabbitLibrary >> authors [
	^ self slotVarNamed: 'authors'
]

{ #category : #accessing }
LcsWarRabbitLibrary >> authors: anObject [
	self slotVarNamed: 'authors' put: anObject
]

{ #category : #accessing }
LcsWarRabbitLibrary >> libraryCategories [
	^ self slotVarNamed: 'libraryCategories'
]

{ #category : #accessing }
LcsWarRabbitLibrary >> libraryCategories: anObject [
	self slotVarNamed: 'libraryCategories' put: anObject
]

{ #category : #query }
LcsWarRabbitLibrary >> libraryCategoryFor: aString [
	^ self libraryCategories libraryCategoryFor: aString
]

{ #category : #accessing }
LcsWarRabbitLibrary >> libraryItems [
	^ self slotVarNamed: 'libraryItems'
]

{ #category : #accessing }
LcsWarRabbitLibrary >> libraryItems: anObject [
	self slotVarNamed: 'libraryItems' put: anObject
]

{ #category : #'slot model' }
LcsWarRabbitLibrary >> systemDomainClasses [
	| collection |
	collection := super systemDomainClasses.
	self addClasses: self class package classes to: collection.
	^ collection
]
