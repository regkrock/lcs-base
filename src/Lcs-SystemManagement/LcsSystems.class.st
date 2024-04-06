Class {
	#name : #LcsSystems,
	#superclass : #LcsCollection,
	#category : #'Lcs-SystemManagement'
}

{ #category : #collection }
LcsSystems class >> collectionClass [
	^ OrderedCollection
]

{ #category : #'gt view\t' }
LcsSystems >> applicationEnvironmentViewChildren [
	^ self collect: [ :each | LcsApplicationEnvironmentViewItem newOn: self label: '' item: each]
]
