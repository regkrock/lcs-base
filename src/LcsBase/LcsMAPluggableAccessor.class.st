Class {
	#name : 'LcsMAPluggableAccessor',
	#superclass : 'MAPluggableAccessor',
	#instVars : [
		'chainAccessor'
	],
	#category : 'LcsBase-Accessor',
	#package : 'LcsBase',
	#tag : 'Accessor'
}

{ #category : 'instance creation' }
LcsMAPluggableAccessor class >> accessors: aCollection read: aReadBlock write: aWriteBlock [
	^ self new
		accessors: aCollection;
		readBlock: aReadBlock;
		writeBlock: aWriteBlock;
		yourself
]

{ #category : 'accessing' }
LcsMAPluggableAccessor >> accessors [
	^ self chainAccessor accessors
]

{ #category : 'accessing' }
LcsMAPluggableAccessor >> accessors: anObject [
	self chainAccessor accessors: anObject asOrderedCollection
]

{ #category : 'chain accessor' }
LcsMAPluggableAccessor >> addSelectorToStartOfAccessChain: aSelector [
	self chainAccessor addSelectorToStartOfAccessChain: aSelector 
]

{ #category : 'accessing' }
LcsMAPluggableAccessor >> chainAccessor [
	^ chainAccessor
]

{ #category : 'accessing' }
LcsMAPluggableAccessor >> chainAccessor: anObject [
	chainAccessor := anObject
]

{ #category : 'initialize' }
LcsMAPluggableAccessor >> initialize [ 
	super initialize.
	self chainAccessor: (LcsMAChainAccesor on: self).
	properties := Dictionary new
]

{ #category : 'model' }
LcsMAPluggableAccessor >> read: aModel [
	^ self readBlock value: (self chainAccessor valueIn: aModel)
]

{ #category : 'model' }
LcsMAPluggableAccessor >> write: anObject to: aModel [
	self writeBlock 
		value: (self chainAccessor targetModelFromSourceModel: aModel) 
		value: self chainAccessor setter
		value: anObject 
]
