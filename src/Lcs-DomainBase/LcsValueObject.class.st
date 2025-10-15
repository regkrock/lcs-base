Class {
	#name : #LcsValueObject,
	#superclass : #LcsDomainObject,
	#instVars : [
		'code',
		'label',
		'description',
		'isDefaultInstance'
	],
	#category : #'Lcs-DomainBase-Core'
}

{ #category : #'slot definitions' }
LcsValueObject class >> codeSlotDefinition [
	<slotDefinition>
	^ LcsValueCodeSlot new
]

{ #category : #'slot definitions' }
LcsValueObject class >> descriptionSlotDefinition [
	<slotDefinition>
	^ LcsDescriptionSlot new
]

{ #category : #'slot definitions' }
LcsValueObject class >> isDefaultInstanceSlotDefinition [
	<slotDefinition>
	^ LcsBooleanSlot new
		slotName: 'isDefaultInstance';
		yourself
]

{ #category : #'slot definitions' }
LcsValueObject class >> labelSlotDefinition [
	<slotDefinition>
	^ LcsLabelSlot new
]

{ #category : #accessing }
LcsValueObject >> code [
	^ self slotVarNamed: 'code' 
]

{ #category : #accessing }
LcsValueObject >> code: anObject [
	self slotVarNamed: 'code' put: anObject 
]

{ #category : #accessing }
LcsValueObject >> description [
	^ self slotVarNamed: 'description' 
]

{ #category : #accessing }
LcsValueObject >> description: anObject [
	self slotVarNamed: 'description' put: anObject 
]

{ #category : #printing }
LcsValueObject >> displayString [
	^ self code asString
]

{ #category : #accessing }
LcsValueObject >> isDefaultInstance [
	^ self slotVarNamed: 'isDefaultInstance' 
]

{ #category : #accessing }
LcsValueObject >> isDefaultInstance: anObject [
	self slotVarNamed: 'isDefaultInstance' put: anObject 
]

{ #category : #search }
LcsValueObject >> key [
	^ self code
]

{ #category : #accessing }
LcsValueObject >> label [ 
	^ self slotVarNamed: 'label' 
]

{ #category : #accessing }
LcsValueObject >> label: anObject [
	self slotVarNamed: 'label' put: anObject 
]
