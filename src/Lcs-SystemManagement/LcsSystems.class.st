Class {
	#name : 'LcsSystems',
	#superclass : 'LcsApplicationObject',
	#traits : 'LtOrderedCollection + LtParentTrait',
	#classTraits : 'LtOrderedCollection classTrait + LtParentTrait classTrait',
	#category : 'Lcs-SystemManagement-Environment',
	#package : 'Lcs-SystemManagement',
	#tag : 'Environment'
}

{ #category : 'gt views' }
LcsSystems >> applicationEnvironmentViewChildren [
	^ self collect: [ :each | LcsApplicationEnvironmentViewItem newOn: self label: '' item: each]
]

{ #category : 'testing' }
LcsSystems >> hasElements [
	^ self isNotEmpty
]

{ #category : 'testing' }
LcsSystems >> hasNoElements [
	^ self isEmpty
]
