Class {
	#name : 'LcsSingletonValueObject',
	#superclass : 'LcsValueObject',
	#category : 'Lcs-DomainBase-Core',
	#package : 'Lcs-DomainBase',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsSingletonValueObject class >> codeSlotDefinition [
	<accessorSlotDefinition>
	^ LcsSingletonValueCodeNameSlot new
]

{ #category : 'defaults' }
LcsSingletonValueObject class >> defaultCode [
	self subclassResponsibility
]

{ #category : 'defaults' }
LcsSingletonValueObject class >> defaultInstance [
	^ false
]

{ #category : 'slot definitions' }
LcsSingletonValueObject class >> descriptionSlotDefinition [
	<accessorSlotDefinition>
	^ LcsSingletonCodeDescriptionSlot new
]

{ #category : 'slot definitions' }
LcsSingletonValueObject class >> isDefaultInstanceSlotDefinition [
	<accessorSlotDefinition>
	^ LcsSingletonCodeIsDefaultInstanceSlot new
]

{ #category : 'slot definitions' }
LcsSingletonValueObject class >> labelSlotDefinition [
	<accessorSlotDefinition>
	^ LcsSingletonLabelSlot new
]
