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
	self slotDefinition validationConditions validate: aValue
]

{ #category : #api }
LcsConditionsValidator >> validte: aValue [ 
	self slotDefinition validationConditions do: [ :each |
		each validate: aValue ]
]
