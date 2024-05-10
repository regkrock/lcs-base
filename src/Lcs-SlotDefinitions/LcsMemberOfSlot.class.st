Class {
	#name : #LcsMemberOfSlot,
	#superclass : #LcsSlotDefintion,
	#instVars : [
		'collectionSourceBlock',
		'referenceCollectionBlock',
		'referenceCollection',
		'collectionSlotName',
		'moduleName'
	],
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #'application environment' }
LcsMemberOfSlot >> collectionModule [
	^ self currentSystem moduleNamed: self moduleName
]

{ #category : #accessing }
LcsMemberOfSlot >> collectionSlotName [
	^ collectionSlotName
]

{ #category : #accessing }
LcsMemberOfSlot >> collectionSlotName: aString [ 
	collectionSlotName := aString
]

{ #category : #accessing }
LcsMemberOfSlot >> defaultInstance [
	^ ((self currentSystem moduleNamed: self moduleName)
		perform: self collectionSlotName asSymbol) defaultInstance
]

{ #category : #private }
LcsMemberOfSlot >> defaultReferenceCollectionBlock [
	^ [ [ self collectionModule perform: self collectionSlotName asSymbol ]
			on: Error
			do: [ :s | self singalNoReferenceCollectionError ] ]
]

{ #category : #initialize }
LcsMemberOfSlot >> initialize [
	super initialize.
	self beRequired.
	self referenceCollectionBlock: self defaultReferenceCollectionBlock
]

{ #category : #accessing }
LcsMemberOfSlot >> moduleName [
	^ moduleName
]

{ #category : #accessing }
LcsMemberOfSlot >> moduleName: aString [ 
	moduleName := aString
]

{ #category : #query }
LcsMemberOfSlot >> referenceCollection [
	^ self referenceCollectionBlock value
]

{ #category : #accessing }
LcsMemberOfSlot >> referenceCollectionBlock [
	referenceCollectionBlock
]

{ #category : #accessing }
LcsMemberOfSlot >> referenceCollectionBlock: aBlock [ 
	referenceCollectionBlock := aBlock
]

{ #category : #query }
LcsMemberOfSlot >> referenceCollectionSource: aCollectionSourceStringOrBlock [
	self referenceCollectionBlock: (aCollectionSourceStringOrBlock isBlock 
		ifTrue: [  aCollectionSourceStringOrBlock ]
		ifFalse: [ [ aCollectionSourceStringOrBlock ] ])
]

{ #category : #error }
LcsMemberOfSlot >> singalNoReferenceCollectionError [
	^ LcsNoReferenceCollectionError
		signal: 'No reference collection defined for: ' , self slotName , ' in class '
				, self domainClass name
]
