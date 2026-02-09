Class {
	#name : 'LcsDomainCollectionSlot',
	#superclass : 'LcsDomainObjectSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'slot model' }
LcsDomainCollectionSlot >> add: aDomainObject [
	self slotTypes do: [ :eachTypeClass | (aDomainObject inheritsFrom: eachTypeClass) ifTrue: [ ^ true ] ]
]

{ #category : 'slot definitions' }
LcsDomainCollectionSlot >> addCollectionMemberType: aClass [
	(self collectionMemberTypes includes: aClass)
		ifFalse: [ self collectionMemberTypes add: aClass ]
]

{ #category : 'actions' }
LcsDomainCollectionSlot >> addPostAddAction: anAction [
	self postAddActions addAction: anAction
]

{ #category : 'actions' }
LcsDomainCollectionSlot >> addPostRemoveAction: anAction [
	self postRemoveActions addAction: anAction
]

{ #category : 'configuration' }
LcsDomainCollectionSlot >> beIdentitySetCollection [
	self collectionClass: LcsSmalltalkConfiguration identitySetClass
]

{ #category : 'configuration' }
LcsDomainCollectionSlot >> beOrderedCollection [
	self collectionClass: OrderedCollection
]

{ #category : 'properties' }
LcsDomainCollectionSlot >> collectionClass [
	^ self propertyAt: 'collectionClass' ifAbsent: [ ]
]

{ #category : 'properties' }
LcsDomainCollectionSlot >> collectionClass: anObject [
	self propertyAt: 'collectionClass' put: anObject
]

{ #category : 'properties' }
LcsDomainCollectionSlot >> collectionMemberTypes [
	^ self propertyAt: 'collectionMemberTypes' ifAbsent: [ ]
]

{ #category : 'properties' }
LcsDomainCollectionSlot >> collectionMemberTypes: anObject [
	self propertyAt: 'collectionMemberTypes' put: anObject
]

{ #category : 'gt views' }
LcsDomainCollectionSlot >> collectionMemberTypesList [
	| stream |
	stream := WriteStream on: String new.
	self collectionMemberTypes 
		do: [ :each | stream nextPutAll: each name ]
		separatedBy: [ stream nextPutAll: '; '].
	^ stream contents
]

{ #category : 'initialize' }
LcsDomainCollectionSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject :slot | slot newObjectWithParent: parentDomainObject ]
]

{ #category : 'initialize' }
LcsDomainCollectionSlot >> initialize [
	super initialize.
	self collectionMemberTypes: OrderedCollection new.
	self postAddActions: LcsPostAddActions new.
	self postRemoveActions: LcsPostRemoveActions new.
	self beIdentitySetCollection
]

{ #category : 'testing' }
LcsDomainCollectionSlot >> isGlobalCollectionSlot [
	^ false
]

{ #category : 'testing' }
LcsDomainCollectionSlot >> isLocalCollectionSlot [
	^ false
]

{ #category : 'testing' }
LcsDomainCollectionSlot >> isSlotTypeIdentitySet [
	^ self slotTypes size = 1
		and: [ self slotTypes includes: LcsSmalltalkConfiguration identitySetClass ]
]

{ #category : 'slot model' }
LcsDomainCollectionSlot >> persistValue: anObject in: aModule [
	(self _currentSlotVarIn: aModule) add: anObject
]

{ #category : 'properties' }
LcsDomainCollectionSlot >> postAddActions [
	^ self propertyAt: 'postAddActions' ifAbsent: [ ]
]

{ #category : 'properties' }
LcsDomainCollectionSlot >> postAddActions: aPostAddActions [
	aPostAddActions parent: self.
	self propertyAt: 'postAddActions' put: aPostAddActions
]

{ #category : 'magritte' }
LcsDomainCollectionSlot >> postAddActionsDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		accessor: (MAChainAccessor accessors: #(#postAddActions #collection));
		label: 'Post Add Actions';
		default: #();
		classes: {LcsPostAddAction};
		priority: 35;
		beModifiable;
		blocItemStencil: [ :anItemViewModel :anItemIndex | 
			anItemViewModel asElement
				fitContent;
				border: (BlBorder paint: BrGlamorousColors disabledButtonBorderColor width: 1);
				margin: (BlInsets
						top: 0
						right: 5
						bottom: 5
						left: 0);
				padding: (BlInsets all: 5);
				background: Color white ];
		newItemStencil: [ LcsPostAddAction new ]
]

{ #category : 'properties' }
LcsDomainCollectionSlot >> postRemoveActions [
	^ self propertyAt: 'postRemoveActions' ifAbsent: [ ]
]

{ #category : 'properties' }
LcsDomainCollectionSlot >> postRemoveActions: aPostRemoveActions [
	aPostRemoveActions parent: self.
	self propertyAt: 'postRemoveActions' put: aPostRemoveActions
]

{ #category : 'actions' }
LcsDomainCollectionSlot >> removePostAddAction: anAction [
	self postAddActions removeAction: anAction
]

{ #category : 'actions' }
LcsDomainCollectionSlot >> removePostRemoveAction: anAction [
	self postRemoveActions removeAction: anAction
]

{ #category : 'verification' }
LcsDomainCollectionSlot >> verifyCollectionItemType: anObject [
	self collectionMemberTypes
		detect: [ :eachClass | anObject isKindOf: eachClass ]
		ifNone: [ self currentUnitOfWork removeAddOf: anObject.
			LcsInvalidSlotTypeError
				signalInvalidType: anObject
				forSlot: self
				for: nil ]
]
