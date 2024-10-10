Class {
	#name : #LuiRequiredProperty,
	#superclass : #LuiComponentProperty,
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #constant }
LuiRequiredProperty class >> propertyName [
	^ 'required'
]

{ #category : #'as yet unclassified' }
LuiRequiredProperty >> beOptional [
	self valueBlock: [ false ]
]

{ #category : #api }
LuiRequiredProperty >> beRequired [
	self valueBlock: [ true ]
]

{ #category : #initialize }
LuiRequiredProperty >> initialize [
	super initialize.
	self valueBlock: [ false ]
]

{ #category : #testing }
LuiRequiredProperty >> isOptional [
	^ self isRequired ~~ true
]

{ #category : #testing }
LuiRequiredProperty >> isRequired [
	^ self propertyValue == true
]
