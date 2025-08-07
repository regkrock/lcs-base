Class {
	#name : #LcsSingletonValueObject,
	#superclass : #LcsValueObject,
	#category : #'Lcs-DomainBase-Core'
}

{ #category : #'slot definitions' }
LcsSingletonValueObject class >> codeSlotDefinition [
	<slotDefinition>
	^ LcsSingletonValueCodeNameSlot new
]

{ #category : #defaults }
LcsSingletonValueObject class >> defaultCode [
	self subclassResponsibility
]

{ #category : #defaults }
LcsSingletonValueObject class >> defaultInstance [
	^ false
]

{ #category : #'slot definitions' }
LcsSingletonValueObject class >> descriptionSlotDefinition [
	<slotDefinition>
	^ LcsSingletonCodeDescriptionSlot new
]

{ #category : #'slot definitions' }
LcsSingletonValueObject class >> isDefaultInstanceSlotDefinition [
	<slotDefinition>
	^ LcsSingletonCodeIsDefaultInstanceSlot new
]

{ #category : #'slot definitions' }
LcsSingletonValueObject class >> labelSlotDefinition [
	<slotDefinition>
	^ LcsSingletonLabelSlot new
]
