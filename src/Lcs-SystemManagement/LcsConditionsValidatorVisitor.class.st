Class {
	#name : #LcsConditionsValidatorVisitor,
	#superclass : #LcsApplicationObject,
	#instVars : [
		'domainObject',
		'errorDescriptions',
		'slotDefinition',
		'visited'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #validations }
LcsConditionsValidatorVisitor class >> newOn: aSlotDefinition [ 
	^ self new
		initializeOn: aSlotDefinition;
		yourself
]

{ #category : #validation }
LcsConditionsValidatorVisitor >> addErrorDescription: aDescription in: aValidationCondition [
]

{ #category : #acccessing }
LcsConditionsValidatorVisitor >> domainObject [
	^ domainObject
]

{ #category : #acccessing }
LcsConditionsValidatorVisitor >> domainObject: aDomainObject [ 
	domainObject := aDomainObject
]

{ #category : #accessing }
LcsConditionsValidatorVisitor >> errorDescriptions [
	^ errorDescriptions
]

{ #category : #accessing }
LcsConditionsValidatorVisitor >> errorDescriptions: anObject [
	errorDescriptions := anObject
]

{ #category : #api }
LcsConditionsValidatorVisitor >> initialize [ 
	super initialize.
	self errorDescriptions: OrderedCollection new.
	self visited: Set new
]

{ #category : #validations }
LcsConditionsValidatorVisitor >> initializeOn: aSlotDefinition [ 
	self slotDefinition: aSlotDefinition
]

{ #category : #accessing }
LcsConditionsValidatorVisitor >> slotDefinition [
	^ slotDefinition 
]

{ #category : #accessing }
LcsConditionsValidatorVisitor >> slotDefinition: aSlotDefinition [ 
	slotDefinition := aSlotDefinition
]

{ #category : #api }
LcsConditionsValidatorVisitor >> validate: anObject [ 
	(self visited includes: anObject) ifTrue: [ ^ self ].
	self visited add: anObject.
	anObject slotModel validate: anObject visitor: self
	"self slotDefinition validationConditions validate: aValue"
]

{ #category : #accessing }
LcsConditionsValidatorVisitor >> visited [
	^ visited
]

{ #category : #accessing }
LcsConditionsValidatorVisitor >> visited: anObject [
	visited := anObject
]
