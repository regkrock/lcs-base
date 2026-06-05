Class {
	#name : 'LuiLocalAccessor',
	#superclass : 'LuiAccessor',
	#instVars : [
		'model'
	],
	#category : 'Lcs-WebComponents-Accessor',
	#package : 'Lcs-WebComponents',
	#tag : 'Accessor'
}

{ #category : 'instance creation' }
LuiLocalAccessor class >> newOn: aComponent [
	^ self new
		initializeOn: aComponent;
		yourself
]

{ #category : 'accessing' }
LuiLocalAccessor >> _model [
	^ model
]

{ #category : 'testing' }
LuiLocalAccessor >> canRead: aModel [
	"Test if ==aModel== can be read."

	^ true
]

{ #category : 'testing' }
LuiLocalAccessor >> canWrite: aModel [
	"Test if ==aModel== can be written."

	^ true
]

{ #category : 'model' }
LuiLocalAccessor >> displayValue [
	^ self model asString
]

{ #category : 'initialize' }
LuiLocalAccessor >> initializeOn: aComponent [ 
	self parent: aComponent
]

{ #category : 'accessing' }
LuiLocalAccessor >> model [
	^ self _model
]

{ #category : 'accessing' }
LuiLocalAccessor >> model: anObject [
	model := anObject
]
