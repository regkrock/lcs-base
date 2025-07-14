Class {
	#name : #LcsMAPluggableAccessor,
	#superclass : #MAPluggableAccessor,
	#instVars : [
		'accessors',
		'parameters'
	],
	#category : #'LcsBase-Accessor'
}

{ #category : #'instance creation' }
LcsMAPluggableAccessor class >> accessors: aCollection arguments: aBlockArguments read: aReadBlock write: aWriteBlock [
	^ self new
		accessors: aCollection;
		parameters: aBlockArguments;
		readBlock: aReadBlock;
		writeBlock: aWriteBlock;
		yourself
]

{ #category : #accessing }
LcsMAPluggableAccessor >> accessors [
	^ accessors
]

{ #category : #accessing }
LcsMAPluggableAccessor >> accessors: anObject [
	accessors := anObject
]

{ #category : #initialize }
LcsMAPluggableAccessor >> initialize [ 
	super initialize.
	self accessors: OrderedCollection new.
	self parameters: OrderedCollection new
]

{ #category : #accessing }
LcsMAPluggableAccessor >> parameters [
	^ parameters
]

{ #category : #accessing }
LcsMAPluggableAccessor >> parameters: anObject [
	parameters := anObject
]

{ #category : #model }
LcsMAPluggableAccessor >> read: aModel [
	^ self readBlock value: aModel value: self accessors value: self parameters
]

{ #category : #model }
LcsMAPluggableAccessor >> write: anObject to: aModel [
	self writeBlock value: aModel value: anObject value: self accessors value: self parameters
]
