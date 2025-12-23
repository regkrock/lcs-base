Class {
	#name : 'LcsUnitsOfWork',
	#superclass : 'LcsApplicationObject',
	#traits : 'LtOrderedCollection + LtParentTrait',
	#classTraits : 'LtOrderedCollection classTrait + LtParentTrait classTrait',
	#category : 'Lcs-SystemManagement-Environment',
	#package : 'Lcs-SystemManagement',
	#tag : 'Environment'
}

{ #category : 'gt views' }
LcsUnitsOfWork >> applicationEnvironmentViewChildren [
	^ self collect: [ :each | LcsApplicationEnvironmentViewItem newOn: self label: '' item: each]
]

{ #category : 'testing' }
LcsUnitsOfWork >> hasElements [
	^ self isNotEmpty
]

{ #category : 'testing' }
LcsUnitsOfWork >> hasNoElements [
	^ self isEmpty
]

{ #category : 'collection' }
LcsUnitsOfWork >> removeUnitsOfWorkFor: aSystem [
	self collection copy
		do: [ :each | each system == aSystem ifTrue: [ self remove: each ] ].
]

{ #category : 'collection' }
LcsUnitsOfWork >> unitOfWorkFor: aSystem [
	^ self
		detect: [ :each | each system == aSystem ]
		ifNone: [ LcsSystemHasNoUnitOfWorkError
				signal: 'No unit of work found for requested system' ]
]
