Class {
	#name : #LcsSystems,
	#superclass : #LcsApplicationObject,
	#traits : 'LtOrderedCollection + LtParentTrait',
	#classTraits : 'LtOrderedCollection classTrait + LtParentTrait classTrait',
	#category : #'Lcs-SystemManagement-Environment'
}

{ #category : #'gt views' }
LcsSystems >> applicationEnvironmentViewChildren [
	^ self collect: [ :each | LcsApplicationEnvironmentViewItem newOn: self label: '' item: each]
]
