Class {
	#name : #LcsMAChainAccesor,
	#superclass : #LcsObject,
	#instVars : [
		'accessors',
		'pluggableAccessor'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #'instance creation' }
LcsMAChainAccesor class >> on: aPluggableAccessor [
	^ self new
		adaptor: aPluggableAccessor;
		yourself 
]

{ #category : #'instance creation' }
LcsMAChainAccesor class >> on: aPluggableAccessor accessors: accessors [
	^ self new
		pluggableAccessor: aPluggableAccessor;
		accessors: accessors;
		yourself 
]

{ #category : #accessing }
LcsMAChainAccesor >> accessors [
	^ accessors
]

{ #category : #accessing }
LcsMAChainAccesor >> accessors: anObject [
	accessors := anObject
]

{ #category : #private }
LcsMAChainAccesor >> allButLastAccessors [
	self accessors size <= 1 ifTrue: [ ^ self accessors ].
	^ self accessors copyFrom: 1 to: ( self accessors size - 1)
]

{ #category : #accessing }
LcsMAChainAccesor >> pluggableAccessor [
	^ pluggableAccessor
]

{ #category : #accessing }
LcsMAChainAccesor >> pluggableAccessor: anObject [
	pluggableAccessor := anObject
]

{ #category : #model }
LcsMAChainAccesor >> setter [
	^ (self accessors last , ':') asSymbol
]

{ #category : #model }
LcsMAChainAccesor >> targetModelFromSourceModel: aModel [
	^ self allButLastAccessors inject: aModel into: [ :eachSelector :targetModel |
		targetModel perform: eachSelector asSymbol ]
]

{ #category : #model }
LcsMAChainAccesor >> valueIn: aModel [
	^ self accessors inject: aModel into: [ :eachSelector :targetModel |
		targetModel perform: eachSelector asSymbol ]
]
