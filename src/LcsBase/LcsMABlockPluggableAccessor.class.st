Class {
	#name : #LcsMABlockPluggableAccessor,
	#superclass : #LcsMAPluggableAccessor,
	#category : #'LcsBase-Accessor'
}

{ #category : #'instance creation' }
LcsMABlockPluggableAccessor class >> accessors: aCollection arguments: aBlockArguments [
	^ self new
		accessors: aCollection;
		blockArguments: aBlockArguments;
		yourself
]

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

{ #category : #defaults }
LcsMABlockPluggableAccessor >> defaultReadBlock [
	^ [ :block :blockArguments | 
			LcsBlockSourceConverter 
				innerSourceCodeOf: block 
				arguments: blockArguments ]
]

{ #category : #defaults }
LcsMABlockPluggableAccessor >> defaultWriteBlock [
	^ [ :blockArguments  :string :existingBlock | 
			LcsBlockSourceConverter 
				blockWithArguments: blockArguments  
				innerSourceCode: string 
				toReplace: existingBlock ]
]

{ #category : #initialize }
LcsMABlockPluggableAccessor >> initialize [ 
	super initialize.
	self blockArguments: OrderedCollection new.
	self readBlock: self defaultReadBlock.
	self writeBlock: self defaultWriteBlock.
]

{ #category : #model }
LcsMABlockPluggableAccessor >> read: aModel [
	^ self readBlock value: (self chainAccessor valueIn: aModel) value: self blockArguments
]

{ #category : #printing }
LcsMABlockPluggableAccessor >> storeBlock: aBlock on: aStream [ 
	aStream nextPutAll: aBlock asString greaseString allButFirst allButLast
]

{ #category : #model }
LcsMABlockPluggableAccessor >> write: aString to: aModel [
	(self chainAccessor targetModelFromSourceModel: aModel) perform: (
		self chainAccessor setter) with: (
			self writeBlock value: self blockArguments value: aString value: (self chainAccessor valueIn: aModel))
]
