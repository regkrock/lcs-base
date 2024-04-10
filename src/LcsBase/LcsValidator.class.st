Class {
	#name : #LcsValidator,
	#superclass : #LcsObject,
	#instVars : [
		'validatedObjects',
		'validationErrors',
		'validationIssues'
	],
	#category : #LcsBase
}

{ #category : #'validation\t\t' }
LcsValidator >> addIssueMessage: aString [
	self validationIssues
		add: (LcsValidatorIssueMessage newOn: self objectBeingValidated message: aString)
]

{ #category : #testing }
LcsValidator >> hasAlreadyBeenValidated: anObject [
	^ self validatedObjects includes: anObject
]

{ #category : #testing }
LcsValidator >> hasNoValidationIssues [
	^ self validationIssues isEmpty
]

{ #category : #testing }
LcsValidator >> hasValidationIssues [
	^ self validationIssues notEmpty
]

{ #category : #'initiailize\t' }
LcsValidator >> initialize [
	super initialize.
	self validatedObjects: OrderedCollection new.
	self validationIssues: OrderedCollection new
]

{ #category : #'validation\t\t' }
LcsValidator >> objectBeingValidated [
	^ self validatedObjects last
]

{ #category : #'validation\t' }
LcsValidator >> objectBeingValidated: anObject [
	self validatedObjects add: anObject
]

{ #category : #'api\t\t' }
LcsValidator >> validate: anObject [
	(self hasAlreadyBeenValidated: anObject) ifTrue: [ ^ self ].
	self objectBeingValidated: anObject.
	self validateCurrentObject
]

{ #category : #'validation\t\t' }
LcsValidator >> validateCurrentObject [
	self subclassResponsibility
]

{ #category : #accessing }
LcsValidator >> validatedObjects [
	^ validatedObjects
]

{ #category : #accessing }
LcsValidator >> validatedObjects: anObject [
	validatedObjects := anObject
]

{ #category : #accessing }
LcsValidator >> validationIssues [
	^ validationIssues
]

{ #category : #accessing }
LcsValidator >> validationIssues: anObject [ 
	validationIssues := anObject
]
