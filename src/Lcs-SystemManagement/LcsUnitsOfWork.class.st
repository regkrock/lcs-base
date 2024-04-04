Class {
	#name : #LcsUnitsOfWork,
	#superclass : #LcsCollection,
	#category : #'Lcs-SystemManagement'
}

{ #category : #collection }
LcsUnitsOfWork class >> collectionClass [
	^ OrderedCollection
]

{ #category : #'collection\t' }
LcsUnitsOfWork >> removeUnitsOfWorkFor: aSystem [
	self collection copy
		do: [ :each | each system == aSystem ifTrue: [ self collection remove: each ] ].
]

{ #category : #'collection\t' }
LcsUnitsOfWork >> unitOfWorkFor: aSystem [
	^ self collection
		detect: [ :each | each system == aSystem ]
		ifNone: [ LcsSystemHasNoUnitOfWorkError
				signal: 'No unit of work found for requested system' ]
]
