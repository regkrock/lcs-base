Class {
	#name : #LxxExampleComponent,
	#superclass : #LcsDomainObject,
	#instVars : [
		'age'
	],
	#category : #'Lcs-SlotDefinitionsTests'
}

{ #category : #'slot  definition' }
LxxExampleComponent class >> ageSlotDefinition [
	<slotDefinition>
	^ LcsIntegerSlot new
		slotName: 'age';
		initialValue: 0;
		yourself
]

{ #category : #accessing }
LxxExampleComponent >> age [
	^ self getValueOfSlotNamed: 'age'
]

{ #category : #accessing }
LxxExampleComponent >> age: aNumber [
	^ self setValueOfSlotNamed: 'age' to: aNumber
]
