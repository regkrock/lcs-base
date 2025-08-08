Class {
	#name : #LcsLocalCollectionItem,
	#superclass : #LcsViewItem,
	#category : #'Lcs-SystemManagement-Core'
}

{ #category : #defaults }
LcsLocalCollectionItem class >> defaultChildrenSelector [
	^ #localCollections
]

{ #category : #accessing }
LcsLocalCollectionItem >> numberOfPendingAdds [
	^ (self currentSystem unitOfWork pendingAddsFor: self) size
]

{ #category : #accessing }
LcsLocalCollectionItem >> numberOfPendingRemovals [
	"^ self currentSystem currentUnitOfWork pendingRemovalsFor: self."
	^ 0
]
