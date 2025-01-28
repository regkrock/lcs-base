Class {
	#name : #LcsLibraryCategory,
	#superclass : #LcsDomainObject,
	#instVars : [
		'categoryName',
		'subcategories'
	],
	#category : #'Lcs-WarRabbitLibrary'
}

{ #category : #'slot definition' }
LcsLibraryCategory class >> categoryNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'categoryName';
		beRequired;
		yourself
]

{ #category : #accessing }
LcsLibraryCategory class >> newFor: aString [
	^ self new
		categoryName: aString;
		yourself 
	
]

{ #category : #'slot definition' }
LcsLibraryCategory class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotModuleName: LcsWarRabbitLibrary moduleName;
		collectionSlotName: 'libraryCategories';
		addSlotType: self;
		yourself
]

{ #category : #'slot definition' }
LcsLibraryCategory class >> subcategoriesSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'subcategories';
		yourself
]

{ #category : #accessing }
LcsLibraryCategory >> categoryName [
		^ self slotVarNamed: 'categoryName'
]

{ #category : #accessing }
LcsLibraryCategory >> categoryName: anObject [
	self slotVarNamed: 'categoryName' put: anObject
]

{ #category : #accessing }
LcsLibraryCategory >> subcategories [
	^ self slotVarNamed: 'subcategories'
]

{ #category : #accessing }
LcsLibraryCategory >> subcategories: anObject [
	^ self slotVarNamed: 'subcategories' put: anObject
]
