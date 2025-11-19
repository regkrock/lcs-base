Class {
	#name : 'LcsLocalCollectionItem',
	#superclass : 'LcsViewItem',
	#category : 'Lcs-SystemManagement-Core',
	#package : 'Lcs-SystemManagement',
	#tag : 'Core'
}

{ #category : 'defaults' }
LcsLocalCollectionItem class >> defaultChildrenSelector [
	^ #localCollections
]

{ #category : 'asking' }
LcsLocalCollectionItem >> collectionSize [
	(self item class inheritsFrom: LcsDomainCollection)
			ifTrue: [ ^ self item collectionSize ].
			
	 ^ self item size 
]

{ #category : 'accessing' }
LcsLocalCollectionItem >> numberOfPendingAdds [
	^ (self currentSystem unitOfWork pendingAddsFor: self) size
]

{ #category : 'accessing' }
LcsLocalCollectionItem >> numberOfPendingRemovals [
	"^ self currentSystem currentUnitOfWork pendingRemovalsFor: self."
	^ 0
]
