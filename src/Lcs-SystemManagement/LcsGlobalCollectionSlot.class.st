"
This is used to define a global collection slot. All of the items stored in this collection are rooted in this collection.
"
Class {
	#name : 'LcsGlobalCollectionSlot',
	#superclass : 'LcsDomainCollectionSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'object initialization' }
LcsGlobalCollectionSlot >> initializeSlotValueIn: aDomainObject [
	super initializeSlotValueIn: aDomainObject.
	self populateCollection: (aDomainObject perform: self slotName asSymbol) 
]

{ #category : 'testing' }
LcsGlobalCollectionSlot >> isGlobalCollectionSlot [
	^ true
]

{ #category : 'properties' }
LcsGlobalCollectionSlot >> loaderClass [
	^ self propertyAt: 'loaderClass' ifAbsent: [ ]
]

{ #category : 'properties' }
LcsGlobalCollectionSlot >> loaderClass: aLoaderClass [
	self propertyAt: 'loaderClass' put: aLoaderClass
]

{ #category : 'load' }
LcsGlobalCollectionSlot >> populateCollection [
	self loaderClass isNil ifTrue: [ ^ self ].
	self loaderClass new load
]

{ #category : 'load' }
LcsGlobalCollectionSlot >> populateCollection: aTargetCollection [
	self loaderClass isNil ifTrue: [ ^ self ].
	self loaderClass new loadInto: aTargetCollection
]
