Class {
	#name : 'LcsMAChainAccesor',
	#superclass : 'LcsObject',
	#instVars : [
		'accessors',
		'pluggableAccessor'
	],
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'instance creation' }
LcsMAChainAccesor class >> on: aPluggableAccessor [
	^ self new
		pluggableAccessor:  aPluggableAccessor;
		yourself 
]

{ #category : 'instance creation' }
LcsMAChainAccesor class >> on: aPluggableAccessor accessors: accessors [
	^ self new
		pluggableAccessor: aPluggableAccessor;
		accessors: accessors;
		yourself 
]

{ #category : 'accessing' }
LcsMAChainAccesor >> accessors [
	^ accessors
]

{ #category : 'accessing' }
LcsMAChainAccesor >> accessors: anObject [
	accessors := anObject asOrderedCollection
]

{ #category : 'chain accessor' }
LcsMAChainAccesor >> addSelectorToStartOfAccessChain: aSelector [
	self accessors addFirst: aSelector
]

{ #category : 'private' }
LcsMAChainAccesor >> allButLastAccessors [
	self accessors size <= 1 ifTrue: [ ^ #() ].
	^ self accessors copyFrom: 1 to: ( self accessors size - 1)
]

{ #category : 'accessing' }
LcsMAChainAccesor >> pluggableAccessor [
	^ pluggableAccessor
]

{ #category : 'accessing' }
LcsMAChainAccesor >> pluggableAccessor: anObject [
	pluggableAccessor := anObject
]

{ #category : 'model' }
LcsMAChainAccesor >> setter [
	^ (self accessors last , ':') asSymbol
]

{ #category : 'model' }
LcsMAChainAccesor >> targetModelFromSourceModel: aModel [
	^ self allButLastAccessors inject: aModel into: [ :targetModel :eachSelector |
		targetModel perform: eachSelector asSymbol ]
]

{ #category : 'model' }
LcsMAChainAccesor >> valueIn: aModel [
	^ self accessors inject: aModel into: [ :targetModel :eachSelector |
		targetModel ifNotNil: [ targetModel perform: eachSelector asSymbol ] ]
]
