Class {
	#name : 'LcsGlobalCollectionViewItem',
	#superclass : 'LcsViewItem',
	#category : 'Lcs-SystemManagement-View',
	#package : 'Lcs-SystemManagement',
	#tag : 'View'
}

{ #category : 'defaults' }
LcsGlobalCollectionViewItem class >> defaultChildrenSelector [
	^ #globalCollections
]

{ #category : 'accessing' }
LcsGlobalCollectionViewItem >> collectionType [
	^ self item collectionType
]

{ #category : 'accessing' }
LcsGlobalCollectionViewItem >> numberOfPendingAdds [
	^ (self currentSystem ifNil: [ 0 ]
		ifNotNil: [ :s | s unitOfWork pendingAddsFor: self ]) size
]

{ #category : 'accessing' }
LcsGlobalCollectionViewItem >> numberOfPendingRemovals [
	"^ self currentSystem currentUnitOfWork pendingRemovalsFor: self."
	^ 0
]
