Class {
	#name : #LxxExampleParentDomain,
	#superclass : #LcsDomainObject,
	#instVars : [
		'boolean'
	],
	#category : #'Lcs-SlotDefinitionsTests'
}

{ #category : #'slot  definition' }
LxxExampleParentDomain class >> booleanSlotDefinition [
	<slotDefinition>
	^ LcsBooleanSlot new
		slotName: 'boolean';
		initialValue: true;
		yourself
]

{ #category : #accessing }
LxxExampleParentDomain >> boolean [
	^ self getValueOfSlotNamed: 'boolean'
]

{ #category : #accessing }
LxxExampleParentDomain >> boolean: aBoolean [
	^ self setValueOfSlotNamed: 'boolean' to: aBoolean
]
