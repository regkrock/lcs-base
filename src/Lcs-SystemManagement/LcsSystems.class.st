Class {
	#name : #LcsSystems,
	#superclass : #LcsParentObject,
	#traits : 'LtOrderedCollection',
	#classTraits : 'LtOrderedCollection classTrait',
	#category : #'Lcs-SystemManagement-Environment'
}

{ #category : #'gt views' }
LcsSystems >> applicationEnvironmentViewChildren [
	^ self collect: [ :each | LcsApplicationEnvironmentViewItem newOn: self label: '' item: each]
]
