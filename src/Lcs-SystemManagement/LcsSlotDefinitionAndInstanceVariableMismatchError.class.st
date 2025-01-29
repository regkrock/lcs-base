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

{ #category : #'gt views' }
LcsSlotDefinitionAndInstanceVariableMismatchError >> gtDomainClassViewFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'Domain Class';
		priority: 20;
		object: [ self domainClass ];
		view: #gtMetaFor:
]

{ #category : #'gt views' }
LcsSlotDefinitionAndInstanceVariableMismatchError >> gtExtraInstVarsViewFor: aView [
	<gtView>
	<gtExceptionView>
	self extraInstVars isEmpty ifTrue: [ ^ aView empty ].
	^ aView list
		title: 'Extra Inst Vars';
		priority: 20;
		items: [ self extraInstVars ]
]

{ #category : #'gt views' }
LcsSlotDefinitionAndInstanceVariableMismatchError >> gtExtraSlotDefinitionsViewFor: aView [
	<gtView>
	<gtExceptionView>
	self extraSlotDefinitions isEmpty ifTrue: [ ^ aView empty ].
	^ aView list
		title: 'Extra Slot Definitions';
		priority: 20;
		items: [ self extraSlotDefinitions ]
]

{ #category : #'slot model - verification' }
LcsSlotDefinitionAndInstanceVariableMismatchError >> mismatchMessage [
	self extraInstVars isEmpty ifTrue: [ ^ 'Has slot definitions that have no matching instance variable'].
	self extraSlotDefinitions isEmpty ifTrue: [ ^ 'Has instance variables that have no matching slot definition'].
	^ 'Has extra instance variables and extra slot definitions'
]

{ #category : #'slot model - verification' }
LcsSlotDefinitionAndInstanceVariableMismatchError >> signalMismatch [
	self signal: self domainClass printString , ' - ' , self mismatchMessage.
]
