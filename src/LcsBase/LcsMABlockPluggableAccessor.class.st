Class {
	#name : #LcsMABlockPluggableAccessor,
	#superclass : #LcsMAPluggableAccessor,
	#category : #'LcsBase-Accessor'
}

{ #category : #'instance creation' }
LcsMABlockPluggableAccessor class >> accessors: aCollection arguments: aBlockArguments read: aReadBlock write: aWriteBlock [
	^ self new
		accessors: aCollection;
		blockArguments: aBlockArguments;
		readBlock: aReadBlock;
		writeBlock: aWriteBlock;
		yourself
]

{ #category : #accessing }
LcsMABlockPluggableAccessor >> blockArguments [
	^ blockArguments
]

{ #category : #accessing }
LcsMABlockPluggableAccessor >> blockArguments: anObject [
	blockArguments := anObject
]

{ #category : #initialize }
LcsMABlockPluggableAccessor >> initialize [ 
	super initialize.
	self blockArguments: OrderedCollection new
]

{ #category : #model }
LcsMABlockPluggableAccessor >> read: aModel [
	^ self readBlock value: aModel value: self accessors value: self blockArguments
]

{ #category : #model }
LcsMABlockPluggableAccessor >> write: anObject to: aModel [
	self writeBlock value: aModel value: anObject value: self accessors value: self blockArguments
]
