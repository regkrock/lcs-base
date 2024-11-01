Class {
	#name : #LuiPluggableAccessor,
	#superclass : #LuiAccessor,
	#instVars : [
		'writeBlock',
		'readBlock'
	],
	#category : #'Lcs-WebComponents-Accessor'
}

{ #category : #'instance creation' }
LuiPluggableAccessor class >> read: aReadBlock write: aWriteBlock [
	^ self new
		readBlock: aReadBlock;
		writeBlock: aWriteBlock;
		yourself
]

{ #category : #comparing }
LuiPluggableAccessor >> = anObject [
	^ super = anObject
		and: [ self readBlock = anObject readBlock
		and: [ self writeBlock = anObject writeBlock ] ]
]

{ #category : #testing }
LuiPluggableAccessor >> canRead: aModel [
	^ self readBlock notNil
]

{ #category : #testing }
LuiPluggableAccessor >> canWrite: aModel [
	^ self writeBlock notNil
]

{ #category : #comparing }
LuiPluggableAccessor >> hash [
	^ super hash bitXor: (self readBlock hash bitXor: self writeBlock hash)
]

{ #category : #testing }
LuiPluggableAccessor >> isAbstract [
	^ false
]

{ #category : #model }
LuiPluggableAccessor >> read: aModel [
	^ self readBlock value: aModel
]

{ #category : #accessing }
LuiPluggableAccessor >> readBlock [
	^ readBlock
]

{ #category : #accessing }
LuiPluggableAccessor >> readBlock: anObject [
	readBlock := anObject
]

{ #category : #printing }
LuiPluggableAccessor >> storeOn: aStream [
	aStream nextPut: $(.
	self class storeOn: aStream.
	aStream nextPutAll: ' read: '.
	self storeBlock: self readBlock on: aStream.
	aStream nextPutAll: ' write: '.
	self storeBlock: self writeBlock on: aStream.
	aStream nextPut: $)
]

{ #category : #model }
LuiPluggableAccessor >> write: anObject to: aModel [
	self writeBlock value: aModel value: anObject
]

{ #category : #accessing }
LuiPluggableAccessor >> writeBlock [
	^ writeBlock
]

{ #category : #accessing }
LuiPluggableAccessor >> writeBlock: anObject [
	writeBlock := anObject
]
