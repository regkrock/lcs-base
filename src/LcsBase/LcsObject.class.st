Class {
	#name : #LcsObject,
	#superclass : #Object,
	#category : #LcsBase
}

{ #category : #transactions }
LcsObject class >> abortTransaction [
	LcsSmalltalkConfiguration gsSystemClass abortTransaction
]

{ #category : #transactions }
LcsObject class >> commitTransaction [
	LcsSmalltalkConfiguration gsSystemClass commitTransaction
]

{ #category : #private }
LcsObject class >> domainObjectClass [
	"This is done for packaging loading purposes"
	^ self subclasses detect: [ :each | each name = #LcsDomainObject ] ifNone: [ nil ]
]

{ #category : #testing }
LcsObject class >> hasNoninitializedEnvironment [
	^ self hasNoninitializedSlotModel
]

{ #category : #testing }
LcsObject class >> hasNoninitializedSlotModel [
	^ self domainObjectClass
		ifNil: [ true ]
		ifNotNil: [ :domainObjectClass | domainObjectClass hasNoninitializedEnvironment ]
]

{ #category : #testing }
LcsObject class >> initializeEnvironment [
	self domainObjectClass
		ifNotNil: [ :domainObjectClass | domainObjectClass initializeEnvironment ]
]

{ #category : #testing }
LcsObject class >> releaseApplicationEnvironment [
	self domainObjectClass
		ifNotNil: [ :domainObjectClass | domainObjectClass releaseApplicationEnvironment ]
]

{ #category : #printing }
LcsObject >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPutAll: ' (objectId: ';
		nextPutAll: self hash displayString;
		nextPutAll: ')'

]
