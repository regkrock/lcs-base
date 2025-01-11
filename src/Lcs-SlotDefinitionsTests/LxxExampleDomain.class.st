Class {
	#name : #LxxExampleDomain,
	#superclass : #LcsDomainObject,
	#instVars : [
		'boolean',
		'composite'
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

{ #category : #'slot  definition' }
LxxExampleDomain class >> compositeSlotDefinition [
	<slotDefinition>
	^ LcsCompositeSlot new
		slotName: 'composite';
		addSlotType: LxxExampleComponent
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

{ #category : #accessing }
LxxExampleDomain >> composite [
	^ self getValueOfSlotNamed: 'composite'
]

{ #category : #accessing }
LxxExampleDomain >> composite: aDomainObject [
	^ self setValueOfSlotNamed: 'composite' to: aDomainObject
]
