Class {
	#name : #LuiAccessor,
	#superclass : #LcsObject,
	#category : #'Lcs-WebComponents-Accessor'
}

{ #category : #converting }
LuiAccessor >> asAccessor [
	^ self
]

{ #category : #testing }
LuiAccessor >> canRead: aModel [
	"Test if ==aModel== can be read."

	^ false
]

{ #category : #testing }
LuiAccessor >> canWrite: aModel [
	"Test if ==aModel== can be written."

	^ false
]

{ #category : #accessing }
LuiAccessor >> defaultLabelFor: aDescription [
	^ aDescription class defaultLabel
]

{ #category : #testing }
LuiAccessor >> handlesSelector: aSelector [
	^ false
]

{ #category : #accessing }
LuiAccessor >> name [
	^ nil
]

{ #category : #printing }
LuiAccessor >> printOn: aStream [
	self storeOn: aStream
]

{ #category : #model }
LuiAccessor >> read: aModel [
	"Read from ==aModel== using the access-strategy of the receiver."

	^ nil
]

{ #category : #printing }
LuiAccessor >> storeOn: aStream [
	self halt.
	self class storeOn: aStream.
	aStream nextPutAll: ' new'
]

{ #category : #model }
LuiAccessor >> write: anObject to: aModel [
	"Write ==anObject== to ==aModel== using the access-strategy of the receiver."
]
