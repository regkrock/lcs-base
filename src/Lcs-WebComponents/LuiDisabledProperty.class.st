Class {
	#name : #LuiDisabledProperty,
	#superclass : #LuiComponentProperty,
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #'as yet unclassified' }
LuiDisabledProperty class >> propertyName [
	^ 'dsiabled'
]

{ #category : #command }
LuiDisabledProperty >> beDisabled [
	self valueBlock: [ true ]
]

{ #category : #command }
LuiDisabledProperty >> beEnabled [
	self valueBlock: [ false ]
]

{ #category : #initialize }
LuiDisabledProperty >> initialize [
	super initialize.
	self valueBlock: [ false ]
]

{ #category : #'as yet unclassified' }
LuiDisabledProperty >> isDisabled [
	^ self cachedValue == true
]

{ #category : #'as yet unclassified' }
LuiDisabledProperty >> isEnabled [
	^ self isDisabled not
]
