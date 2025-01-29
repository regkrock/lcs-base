Class {
	#name : #LcsSlotDefinitionAndInstanceVariableMismatchError,
	#superclass : #LcsError,
	#instVars : [
		'domainClass',
		'extraInstVars',
		'extraSlotDefinitions'
	],
	#category : #'Lcs-SystemManagement-Domain'
}

{ #category : #'slot model - verification' }
LcsSlotDefinitionAndInstanceVariableMismatchError class >> signalFrom: anObject unmatchInstVars: localInstVarNames slotDefinitions: slotDefinitions [ 
	self new
		domainClass: anObject;
		extraInstVars: localInstVarNames;
		extraSlotDefinitions: slotDefinitions;
		signalMismatch
]

{ #category : #accessing }
LcsSlotDefinitionAndInstanceVariableMismatchError >> domainClass [
	^ domainClass
]

{ #category : #accessing }
LcsSlotDefinitionAndInstanceVariableMismatchError >> domainClass: anObject [
	domainClass := anObject
]

{ #category : #accessing }
LcsSlotDefinitionAndInstanceVariableMismatchError >> extraInstVars [
	^ extraInstVars
]

{ #category : #accessing }
LcsSlotDefinitionAndInstanceVariableMismatchError >> extraInstVars: anObject [
	extraInstVars := anObject
]

{ #category : #accessing }
LcsSlotDefinitionAndInstanceVariableMismatchError >> extraSlotDefinitions [
	^ extraSlotDefinitions
]

{ #category : #accessing }
LcsSlotDefinitionAndInstanceVariableMismatchError >> extraSlotDefinitions: anObject [
	extraSlotDefinitions := anObject
]

{ #category : #'slot model - verification' }
LcsSlotDefinitionAndInstanceVariableMismatchError >> mismatchMessage [
	self extraInstVars isEmpty ifTrue: [ ^ 'Has slot definitions that have no matching instance variable'].
	self extraSlotDefinitions isEmpty ifTrue: [ ^ 'Has instance variables that have no matching slot definition'].
	^ 'Has extra instance variables and extra slot definitions'
]

{ #category : #'slot model - verification' }
LcsSlotDefinitionAndInstanceVariableMismatchError >> signalMismatch [
	self signal: self mismatchMessage.
]
