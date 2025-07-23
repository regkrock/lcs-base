Class {
	#name : #LcsConditionsValidator,
	#superclass : #LcsApplicationObject,
	#instVars : [
		'domainObject',
		'errorDescriptions',
		'slotDefinition'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #validations }
LcsConditionsValidator class >> newOn: aSlotDefinition [ 
	^ self new
		initializeOn: aSlotDefinition;
		yourself
]

{ #category : #errors }
LcsConditionsValidator >> addError: aMessage [
	self errorDescriptions add: aMessage
]

{ #category : #errors }
LcsConditionsValidator >> addErrorDescription: aMessage [
	self errorDescriptions add: aMessage
]

{ #category : #validation }
LcsConditionsValidator >> addErrorDescription: aDescription in: aValidationCondition [
]

{ #category : #acccessing }
LcsConditionsValidator >> domainObject [
	^ domainObject
]

{ #category : #acccessing }
LcsConditionsValidator >> domainObject: aDomainObject [ 
	domainObject := aDomainObject
]

{ #category : #accessing }
LcsConditionsValidator >> errorDescriptions [
	^ errorDescriptions
]

{ #category : #accessing }
LcsConditionsValidator >> errorDescriptions: anObject [
	errorDescriptions := anObject
]

{ #category : #testing }
LcsConditionsValidator >> hasError: aDescription [
	| result |
	result := self errorDescriptions detect: [ :each | each = aDescription ] ifNone: [ ].
	^ result notNil
]

{ #category : #testing }
LcsConditionsValidator >> hasErrors [
	^ self errorDescriptions notEmpty
]

{ #category : #testing }
LcsConditionsValidator >> hasNoErrors [
	^ self errorDescriptions isEmpty
]

{ #category : #api }
LcsConditionsValidator >> initialize [ 
	super initialize.
	self errorDescriptions: OrderedCollection new
]

{ #category : #validations }
LcsConditionsValidator >> initializeOn: aSlotDefinition [ 
	self slotDefinition: aSlotDefinition
]

{ #category : #accessing }
LcsConditionsValidator >> slotDefinition [
	^ slotDefinition 
]

{ #category : #accessing }
LcsConditionsValidator >> slotDefinition: aSlotDefinition [ 
	slotDefinition := aSlotDefinition
]

{ #category : #api }
LcsConditionsValidator >> validate: aValue [ 
	self slotDefinition validate: aValue withValidator: self
]
