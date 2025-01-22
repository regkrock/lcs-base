Class {
	#name : #LcsSystems,
	#superclass : #LcsCollection,
	#category : #'Lcs-SystemManagement-Environment'
}

{ #category : #collection }
LcsSystems class >> collectionClass [
	^ OrderedCollection
]

{ #category : #'gt view' }
LcsSystems >> applicationEnvironmentViewChildren [
	^ self collect: [ :each | LcsApplicationEnvironmentViewItem newOn: self label: '' item: each]
]
