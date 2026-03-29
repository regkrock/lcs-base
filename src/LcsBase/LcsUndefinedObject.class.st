Class {
	#name : 'LcsUndefinedObject',
	#superclass : 'UndefinedObject',
	#category : 'LcsBase-Core',
	#package : 'LcsBase',
	#tag : 'Core'
}

{ #category : 'testing' }
LcsUndefinedObject >> isLcsUndefinedObject [
	^ true
]

{ #category : 'printing' }
LcsUndefinedObject >> printOn: aStream [
	"Refer to the comment in Object|printOn:."

	aStream nextPutAll: 'nil(LcsUndefinedObject)'
]
