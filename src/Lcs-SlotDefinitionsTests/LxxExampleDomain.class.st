Class {
	#name : #LxxExampleDomain,
	#superclass : #LcsDomainObject,
	#instVars : [
		'boolean'
	],
	#category : #'Lcs-SlotDefinitionsTests'
}

{ #category : #'slot  definition' }
LxxExampleDomain class >> booleanSlotDefinition [
	<slotDefinition>
	^ LcsBooleanSlot new
		slotName: 'boolean';
		initialValue: true;
		yourself
]

{ #category : #accessing }
LxxExampleDomain >> boolean [
	^ self getValueOfSlotNamed: 'boolean'
]

{ #category : #accessing }
LxxExampleDomain >> boolean: aBoolean [
	^ self setValueOfSlotNamed: 'boolean' to: aBoolean
]
