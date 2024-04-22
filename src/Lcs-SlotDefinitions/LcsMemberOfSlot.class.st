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

{ #category : #accessing }
LcsMemberOfSlot >> collectionModule [
	^ self currentSystem moduleNamed: self moduleName
]

{ #category : #'slot definition' }
LcsMemberOfSlot >> collectionSlotName [
	^ collectionSlotName
]

{ #category : #'slot definition' }
LcsMemberOfSlot >> collectionSlotName: aString [ 
	collectionSlotName := aString
]

{ #category : #accessing }
LcsMemberOfSlot >> defaultReferenceCollectionBlock [
	^ [ [ self collectionModule perform: self collectionSlotName asSymbol ]
			on: Error
			do: [ :s | self singalNoReferenceCollectionError ] ]
]

{ #category : #accessing }
LcsMemberOfSlot >> initialize [
	super initialize.
	self beRequired.
	self referenceCollectionBlock: self defaultReferenceCollectionBlock
]

{ #category : #acccessing }
LcsMemberOfSlot >> moduleName [
	^ moduleName
]

{ #category : #acccessing }
LcsMemberOfSlot >> moduleName: aString [ 
	moduleName := aString
]

{ #category : #query }
LcsMemberOfSlot >> referenceCollection [
	^ self referenceCollectionBlock value
]

{ #category : #query }
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
