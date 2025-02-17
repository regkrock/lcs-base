Class {
	#name : #LcsUnknownLibraryItem,
	#superclass : #LcsLibraryItem,
	#instVars : [
		'parts',
		'originalLine'
	],
	#category : #'Lcs-WarRabbitLibrary'
}

{ #category : #'instance creation' }
LcsUnknownLibraryItem class >> newOn: aString [ 
	^ self new
		initializeOn: aString;
		yourself
]

{ #category : #'slot definitions' }
LcsUnknownLibraryItem class >> originalLineSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'originalLine';
		yourself
]

{ #category : #'slot definitions' }
LcsUnknownLibraryItem class >> partsSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'parts';
		yourself
]

{ #category : #initialize }
LcsUnknownLibraryItem >> initialize [
	super initialize.
	self parts: OrderedCollection new
]

{ #category : #initialize }
LcsUnknownLibraryItem >> initializeOn: aString [ 

	self originalLine: aString.
	(aString at: 1) = Character tab
		ifTrue:[self parts add: String new].
	self parts addAll: (aString substrings: {Character tab})
]

{ #category : #accessing }
LcsUnknownLibraryItem >> initializeOn: aString parts: protoItemParts [ 
	self 
		originalLine: aString;
		parts: protoItemParts
]

{ #category : #accessing }
LcsUnknownLibraryItem >> originalLine [
	^ self slotVarNamed: 'originalLine'
]

{ #category : #accessing }
LcsUnknownLibraryItem >> originalLine: anObject [
	self slotVarNamed: 'originalLine' put: anObject originalLine
]

{ #category : #accessing }
LcsUnknownLibraryItem >> parts [
	^ self slotVarNamed: 'parts'
]

{ #category : #initialize }
LcsUnknownLibraryItem >> parts: anObject [ 
	^ self slotVarNamed: 'parts' put: anObject
]
