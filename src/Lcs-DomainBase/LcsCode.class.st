Class {
	#name : #LcsCode,
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
LcsCode class >> codeSlotDefinition [
	<slotDefinition>
	^ LcsCodeSlot new
]

{ #category : #'slot definitions' }
LcsCode class >> descriptionSlotDefinition [
	<slotDefinition>
	^ LcsDescriptionSlot new
]

{ #category : #'slot definitions' }
LcsCode class >> isDefaultInstanceSlotDefinition [
	<slotDefinition>
	^ LcsBooleanSlot new
		slotName: 'isDefaultInstance';
		yourself
]

{ #category : #'slot definitions' }
LcsCode class >> labelSlotDefinition [
	<slotDefinition>
	^ LcsLabelSlot new
]

{ #category : #accessing }
LcsCode >> code [
	^ self slotVarNamed: 'code' 
]

{ #category : #accessing }
LcsCode >> code: anObject [
	self slotVarNamed: 'code' put: anObject 
]

{ #category : #accessing }
LcsCode >> description [
	^ self slotVarNamed: 'description' 
]

{ #category : #accessing }
LcsCode >> description: anObject [
	self slotVarNamed: 'description' put: anObject 
]

{ #category : #accessing }
LcsCode >> isDefaultInstance [
	^ self slotVarNamed: 'isDefaultInstance' 
]

{ #category : #accessing }
LcsCode >> isDefaultInstance: anObject [
	self slotVarNamed: 'isDefaultInstance' put: anObject 
]

{ #category : #search }
LcsCode >> key [
	^ self code
]

{ #category : #accessing }
LcsCode >> label [ 
	^ self slotVarNamed: 'label' 
]

{ #category : #accessing }
LcsCode >> label: anObject [
	self slotVarNamed: 'label' put: anObject 
]
