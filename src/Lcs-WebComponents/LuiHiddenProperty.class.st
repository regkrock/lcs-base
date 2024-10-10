Class {
	#name : #LuiHiddenProperty,
	#superclass : #LuiComponentProperty,
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #constant }
LuiHiddenProperty class >> propertyName [
	^ 'hidden'
]

{ #category : #command }
LuiHiddenProperty >> beHidden [
	self valueBlock: [ true ]
]

{ #category : #command }
LuiHiddenProperty >> beVisible [
	self valueBlock: [ false ]
]

{ #category : #'as yet unclassified' }
LuiHiddenProperty >> initialize [
	super initialize.
	self valueBlock: [ false ]
]

{ #category : #'as yet unclassified' }
LuiHiddenProperty >> isHidden [
	^ self propertyValue == true
]

{ #category : #'as yet unclassified' }
LuiHiddenProperty >> isVisible [
	^ self isHidden not
]
