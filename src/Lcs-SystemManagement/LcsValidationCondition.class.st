Class {
	#name : #LcsValidationCondition,
	#superclass : #LcsApplicationObject,
	#traits : 'LtParentTrait',
	#classTraits : 'LtParentTrait classTrait',
	#instVars : [
		'description',
		'conditionBlock'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #accessing }
LcsValidationCondition >> conditionBlock [
	^ conditionBlock
]

{ #category : #accessing }
LcsValidationCondition >> conditionBlock: anObject [
	conditionBlock := anObject
]

{ #category : #accessing }
LcsValidationCondition >> description [
	^ description
]

{ #category : #accessing }
LcsValidationCondition >> description: anObject [
	description := anObject
]

{ #category : #validation }
LcsValidationCondition >> evaluateWith: aValidator [
	(self conditionBlock value: aValidator domainObject) ifFalse: [
		aValidator addErrorDescription: self description in: self ]
]

{ #category : #'slot model' }
LcsValidationCondition >> slotDefinition [
	^ self parent slotDefinition
]

{ #category : #validation }
LcsValidationCondition >> validate: aValue [
	(self conditionBlock value: aValue) ifFalse: [
		LcsSlotValidationError signalInvalidValue: aValue forCondition: self inSlot: self slotDefinition ]
]
